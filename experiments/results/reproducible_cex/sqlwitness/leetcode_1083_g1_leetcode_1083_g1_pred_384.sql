-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 2), (-1, 'iPhone', NULL), (2, 'S8', 1), (0, 'S8', 2), (3, NULL, 2), (4, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS T1 JOIN PRODUCT AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID), BOTH_DATA AS (SELECT DISTINCT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('S8', 'iPhone')), ONLY_IPHONE AS (SELECT DISTINCT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('iPhone')) SELECT BUYER_ID FROM BOTH_DATA WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM ONLY_IPHONE);

/*
Prediction Result:
(None,)
*/