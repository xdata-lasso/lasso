-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'G4', 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 101, '2019-01-01', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 102, '2019-01-02', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 102, '2019-01-03', 1, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 103, '2019-01-04', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 104, '2019-01-05', 1, 1200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(101,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLG, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHN_FLG FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM CTE1 WHERE S8_FLG >= '1' AND IPHN_FLG = '0';

/*
Prediction Result:
*/