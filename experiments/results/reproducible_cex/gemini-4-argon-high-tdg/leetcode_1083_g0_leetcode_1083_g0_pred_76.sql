-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'G4', 600);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'iPhone', 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 100, '2019-06-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 100, '2019-06-02', 1, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 200, '2019-06-03', 1, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(100,)
*/

-- Prediction Query
WITH A AS (SELECT SALES.BUYER_ID FROM PRODUCT LEFT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'S8'), B AS (SELECT SALES.BUYER_ID FROM PRODUCT LEFT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone') SELECT DISTINCT A.BUYER_ID FROM A WHERE NOT BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT LEFT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/