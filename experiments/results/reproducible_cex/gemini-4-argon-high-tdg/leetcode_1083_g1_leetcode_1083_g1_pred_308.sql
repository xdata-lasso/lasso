-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-05-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, NULL, '2019-05-02', 1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH PRODUCTSALES AS (SELECT S.SELLER_ID, S.PRODUCT_ID, S.BUYER_ID, S.SALE_DATE, S.QUANTITY, S.PRICE, P.PRODUCT_NAME, P.UNIT_PRICE FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID), BUYS8 AS (SELECT DISTINCT BUYER_ID FROM PRODUCTSALES WHERE PRODUCT_NAME = 'S8'), NOTBUYIPHONE AS (SELECT DISTINCT BUYER_ID FROM PRODUCTSALES WHERE NOT BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM PRODUCTSALES WHERE PRODUCT_NAME = 'iPhone')) SELECT DISTINCT B.BUYER_ID FROM BUYS8 AS B JOIN NOTBUYIPHONE AS N ON B.BUYER_ID = N.BUYER_ID;

/*
Prediction Result:
*/