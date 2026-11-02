-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, NULL, '2019-09-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 5, '2019-09-02', 1, 800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(5,)
*/

-- Prediction Query
WITH IPHONEBUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'iPhone'), S8BUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'S8') SELECT DISTINCT A.BUYER_ID FROM SALES AS A CROSS JOIN S8BUYERS AS I WHERE A.BUYER_ID = I.BUYER_ID AND NOT A.BUYER_ID IN (SELECT BUYER_ID FROM IPHONEBUYERS);

/*
Prediction Result:
(5,)
*/