-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'S8', 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 100, '2023-01-01', 1, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(100,)
*/

-- Prediction Query
WITH S8_BUYERS AS (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT AS P WHERE PRODUCT_NAME = 'S8')), IPHONE_BUYERS AS (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT AS P WHERE PRODUCT_NAME = 'iPhone')) SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.BUYER_ID IN (SELECT A.BUYER_ID FROM S8_BUYERS AS A) AND NOT S.BUYER_ID IN (SELECT B.BUYER_ID FROM IPHONE_BUYERS AS B);

/*
Prediction Result:
*/