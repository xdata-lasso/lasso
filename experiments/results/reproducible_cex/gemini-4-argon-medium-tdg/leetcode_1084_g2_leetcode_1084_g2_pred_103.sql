-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Exact Lower Bound', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'Exact Upper Bound', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'Exact Both Bounds', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Just Before Lower', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Just After Upper', 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 100, '2019-01-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 100, '2019-03-31', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 100, '2019-01-01', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 11, 101, '2019-03-31', 2, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 10, 100, '2018-12-31', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 11, 101, '2019-02-15', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 10, 100, '2019-02-15', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 11, 101, '2019-04-01', 1, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, 'Exact Lower Bound')
(2, 'Exact Upper Bound')
(3, 'Exact Both Bounds')
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_ID, (CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 1 ELSE 0 END) AS SPRING_SALE FROM SALES), B AS (SELECT PRODUCT_ID, SUM(SPRING_SALE) AS SPRING_SALE, COUNT(*) AS TOTAL FROM A GROUP BY PRODUCT_ID HAVING SPRING_SALE <> 0 AND TOTAL = SPRING_SALE) SELECT B.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM B JOIN PRODUCT ON B.PRODUCT_ID = PRODUCT.PRODUCT_ID;

/*
Prediction Result:
(1, 'Exact Lower Bound')
(2, 'Exact Upper Bound')
*/