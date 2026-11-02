-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'StartBoundOnly', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'EndBoundOnly', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'BothBounds', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'OneDayBeforeAndStart', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'EndAndOneDayAfter', 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'OneDayBeforeOnly', 600);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (7, 'OneDayAfterOnly', 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 11, 21, '2019-01-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 12, 22, '2019-03-31', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 13, 23, '2019-01-01', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 13, 24, '2019-03-31', 2, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 14, 25, '2018-12-31', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 14, 26, '2019-01-01', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 15, 27, '2019-03-31', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 15, 28, '2019-04-01', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 16, 29, '2018-12-31', 1, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 17, 30, '2019-04-01', 1, 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, 'StartBoundOnly')
(2, 'EndBoundOnly')
(3, 'BothBounds')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM SALES NATURAL JOIN PRODUCT WHERE SALE_DATE < '2019-03-31' AND SALE_DATE > '2019-01-01' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') GROUP BY PRODUCT_ID;

/*
Prediction Result:
*/