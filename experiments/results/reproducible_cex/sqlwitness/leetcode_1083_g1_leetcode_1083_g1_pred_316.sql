-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (-1, NULL, 1), (1, 'default2', 1), (2, NULL, 2), (3, 'default2', 2), (4, 'default2', 2), (5, 'S8', NULL), (6, 'default2', NULL), (7, 'iPhone', NULL), (8, 'iPhone', 1), (9, 'default1', NULL), (10, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, NULL, NULL, NULL, 1), (3, -1, 1, '2023-01-02', 1, 1), (4, -1, 0, '2023-01-01', 1, 2), (4, -1, 0, NULL, 1, 1), (2, NULL, -1, '2023-01-02', NULL, 2), (2, 0, 1, NULL, 1, 2), (10, 0, NULL, '2023-01-02', 1, 1), (5, NULL, 2, '2023-01-02', 2, 1), (6, 2, -1, '2023-01-01', 2, 1), (NULL, NULL, 1, NULL, 2, 1), (0, 1, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH CTE AS (SELECT BUYER_ID FROM PRODUCT AS P INNER JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), CTE2 AS (SELECT BUYER_ID FROM PRODUCT AS P INNER JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT A.BUYER_ID FROM CTE AS A LEFT JOIN CTE2 AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(2,)
*/