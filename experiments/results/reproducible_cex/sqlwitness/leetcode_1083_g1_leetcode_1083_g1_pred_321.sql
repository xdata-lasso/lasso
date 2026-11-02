-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (2, 'default2', 2), (-1, NULL, 1), (0, 'default1', 2), (3, 'S8', 2), (4, 'default1', NULL), (5, 'iPhone', NULL), (6, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, -1, '2023-01-02', NULL, 2), (1, 2, NULL, NULL, 2, 1), (3, 0, NULL, NULL, NULL, NULL), (-1, 0, NULL, '2023-01-02', NULL, NULL), (0, 0, -1, '2023-01-01', 2, 1), (1, 2, -1, '2023-01-02', 1, 1), (NULL, 0, NULL, '2023-01-01', 1, 1), (5, -1, 2, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH SALES_EXPANDED AS (SELECT S.*, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID), SUMMARY AS (SELECT SE.BUYER_ID, MAX(CASE WHEN SE.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, MAX(CASE WHEN SE.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES_EXPANDED AS SE GROUP BY SE.BUYER_ID) SELECT BUYER_ID FROM SUMMARY WHERE IPHONE = 0 AND S8 = 1;

/*
Prediction Result:
(None,)
(-1,)
*/