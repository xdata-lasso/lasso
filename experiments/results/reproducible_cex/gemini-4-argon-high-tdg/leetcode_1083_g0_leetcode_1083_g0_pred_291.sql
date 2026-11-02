-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'S8+', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 's8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'iPhone', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'iPhone 13', 1100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'iphone', 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 1, '2019-05-01', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 2, '2019-05-02', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 3, '2019-05-03', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 3, '2019-05-04', 1, 1100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 4, '2019-05-05', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 4, '2019-05-06', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 5, '2019-05-07', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 5, '2019-05-08', 1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, GROUP_CONCAT(P.PRODUCT_NAME) AS PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID) SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME LIKE '%S8%' AND PRODUCT_NAME NOT LIKE '%IPHONE%';

/*
Prediction Result:
(1,)
(2,)
*/