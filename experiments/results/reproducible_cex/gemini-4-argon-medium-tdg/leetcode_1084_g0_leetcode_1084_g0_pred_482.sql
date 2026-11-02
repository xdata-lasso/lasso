-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inclusivity, deduplication (multiple sales in Q1), products sold both inside and outside Q1, products sold only outside Q1, and products with no sales.
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Q1_Single', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'Q1_Multiple', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'Q1_and_Before', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Q1_and_After', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Only_Outside', 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'No_Sales', 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 20, '2019-02-15', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 20, '2019-01-10', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 11, 21, '2019-03-20', 2, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 20, '2018-12-15', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 22, '2019-02-10', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 10, 20, '2019-02-10', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 12, 23, '2019-04-15', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 10, 20, '2018-05-05', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 10, 20, '2019-06-06', 1, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'Q1_Single')
(2, 'Q1_Multiple')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE NOT P.PRODUCT_ID IN (SELECT A.PRODUCT_ID FROM SALES AS A WHERE A.SALE_DATE < '2019-01-01' OR A.SALE_DATE > '2019-03-31');

/*
Prediction Result:
(1, 'Q1_Single')
(2, 'Q1_Multiple')
(6, 'No_Sales')
*/