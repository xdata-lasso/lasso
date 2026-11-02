-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'S8', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'S8', 950);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (30, 'iPhone', 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 100, 50, '2020-01-01', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 101, 50, '2020-01-02', 2, 1800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 102, 50, '2020-01-03', 1, 950);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(50,)
*/

-- Prediction Query
SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/