-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 401, '2019-03-01', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, NULL, '2019-03-02', 1, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, NULL, '2019-03-03', 1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT SALES.BUYER_ID, SALES.PRODUCT_ID FROM SALES LEFT JOIN (SELECT BUYER_ID, PRODUCT_NAME, PRODUCT.PRODUCT_ID FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'iPhone') AS P ON SALES.BUYER_ID = P.BUYER_ID WHERE P.BUYER_ID IS NULL) SELECT DISTINCT CTE1.BUYER_ID AS BUYER_ID FROM CTE1 LEFT JOIN PRODUCT ON CTE1.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(401,)
(None,)
*/