-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'S8', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'S8', 950);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (30, 'iPhone', 1100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (40, 'iPhone', 1150);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 301, '2019-02-01', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 1, 301, '2019-02-02', 1, 950);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 302, '2019-02-03', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (40, 1, 302, '2019-02-04', 1, 1150);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 1, 303, '2019-02-05', 1, 950);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 1, 303, '2019-02-06', 1, 1100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(301,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID AS BOUGHTS8 FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'S8')), CTE2 AS (SELECT S.BUYER_ID AS BOUGHTIPHONE FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'iPhone')) SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.BUYER_ID IN (SELECT BOUGHTS8 FROM CTE1) AND NOT S.BUYER_ID IN (SELECT BOUGHTIPHONE FROM CTE2);

/*
Prediction Result:
(301,)
(302,)
*/