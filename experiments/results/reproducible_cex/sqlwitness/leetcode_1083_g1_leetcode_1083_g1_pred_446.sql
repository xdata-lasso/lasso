-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (2, NULL, NULL), (-1, 'S8', NULL), (1, 'S8', 2), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'iPhone', NULL), (6, 'S8', NULL), (7, 'iPhone', 2), (8, 'default2', 1), (9, 'default1', 1), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 2, -1, NULL, 2, NULL), (4, 1, 0, '2023-01-02', 1, 2), (NULL, 2, 2, '2023-01-02', 2, NULL), (4, NULL, NULL, NULL, 1, 1), (0, NULL, 2, '2023-01-02', 2, 2), (5, -1, 2, '2023-01-02', NULL, NULL), (9, 0, 0, '2023-01-01', 2, NULL), (2, NULL, 2, '2023-01-02', 2, 1), (NULL, 1, NULL, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT SALES.BUYER_ID, SALES.PRODUCT_ID FROM SALES LEFT JOIN (SELECT BUYER_ID, PRODUCT_NAME, PRODUCT.PRODUCT_ID FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone') AS P ON SALES.BUYER_ID = P.BUYER_ID WHERE P.BUYER_ID IS NULL) SELECT DISTINCT CTE1.BUYER_ID AS BUYER_ID FROM CTE1 LEFT JOIN PRODUCT ON CTE1.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(-1,)
(0,)
(None,)
*/