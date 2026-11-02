-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', NULL), (2, 'default1', 1), (-1, 'iPhone', 1), (1, 'default2', NULL), (3, 'S8', NULL), (4, 'iPhone', 2), (5, 'iPhone', 1), (6, 'default2', NULL), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 2, NULL, 1, 1), (3, 0, 1, '2023-01-01', NULL, 1), (7, 0, 1, NULL, 1, NULL), (3, 2, NULL, NULL, 1, 2), (-1, 2, 0, NULL, 1, 1), (0, 0, NULL, '2023-01-02', 1, NULL), (0, NULL, NULL, NULL, NULL, 1), (-1, 1, 1, '2023-01-01', 2, 1), (0, 1, -1, '2023-01-02', 2, 1), (3, 2, 1, '2023-01-01', 1, NULL), (5, -1, 1, '2023-01-02', NULL, NULL), (6, NULL, -1, NULL, NULL, 2), (1, 1, NULL, NULL, NULL, 2), (5, NULL, 0, '2023-01-01', 2, NULL), (NULL, NULL, -1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH PRODUCT_BUYER AS (SELECT DISTINCT PRODUCT_NAME, BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT P1.BUYER_ID FROM PRODUCT_BUYER AS P1 LEFT JOIN PRODUCT_BUYER AS P2 ON P1.BUYER_ID = P2.BUYER_ID AND P2.PRODUCT_NAME = 'iPhone' WHERE P1.PRODUCT_NAME = 'S8' AND P2.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(-1,)
*/