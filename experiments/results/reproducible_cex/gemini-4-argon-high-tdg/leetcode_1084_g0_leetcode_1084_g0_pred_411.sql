-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'StartBoundary', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'EndBoundary', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'FullSpanQ1', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'BeforeStartOffByOne', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'AfterEndOffByOne', 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'March30Product', 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-01-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 2, '2019-03-31', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 3, '2019-01-01', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 4, '2019-03-31', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, 1, '2018-12-31', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, 2, '2019-01-01', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 2, 3, '2019-03-31', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 2, 4, '2019-04-01', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 3, 1, '2019-03-30', 1, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'StartBoundary')
(2, 'EndBoundary')
(3, 'FullSpanQ1')
(6, 'March30Product')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-04-01');

/*
Prediction Result:
(1, 'StartBoundary')
(2, 'EndBoundary')
(3, 'FullSpanQ1')
(5, 'AfterEndOffByOne')
(6, 'March30Product')
*/