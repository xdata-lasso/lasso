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
WITH C1 AS (SELECT P.PRODUCT_ID AS C1_P, PRODUCT_NAME, BUYER_ID FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), C2 AS (SELECT P.PRODUCT_ID AS C3_P, PRODUCT_NAME, BUYER_ID FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT C1.BUYER_ID FROM C1 CROSS JOIN C2 WHERE NOT C1.BUYER_ID IN (SELECT C2.BUYER_ID FROM C2);

/*
Prediction Result:
*/