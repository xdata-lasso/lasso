-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 's8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'S8 Pro', 1200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'S8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'iphone', 1400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'iPhone 12', 1500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'iPhone', 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2020-01-01', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 2, '2020-01-01', 1, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 3, '2020-01-01', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 3, '2020-01-02', 1, 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 3, '2020-01-03', 1, 1500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 4, '2020-01-01', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 4, '2020-01-02', 1, 1400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME LIKE '%IPHONE%') AND PRODUCT_NAME LIKE '%S8';

/*
Prediction Result:
(1,)
*/