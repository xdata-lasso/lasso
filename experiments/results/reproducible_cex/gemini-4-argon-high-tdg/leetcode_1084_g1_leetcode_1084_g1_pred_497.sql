-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'StartBoundaryOnly', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'EndBoundaryOnly', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (30, 'BothBoundaries', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (40, 'OneDayBeforeStart', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (50, 'OneDayAfterEnd', 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (60, 'OnlyDayBefore', 600);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (70, 'OnlyDayAfter', 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 2, '2019-01-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 1, 3, '2019-03-31', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 2, 4, '2019-01-01', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 3, 5, '2019-03-31', 2, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (40, 2, 6, '2018-12-31', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (40, 2, 7, '2019-02-01', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (50, 3, 8, '2019-02-01', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (50, 3, 9, '2019-04-01', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (60, 4, 1, '2018-12-31', 1, 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (70, 5, 2, '2019-04-01', 1, 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(10, 'StartBoundaryOnly')
(20, 'EndBoundaryOnly')
(30, 'BothBoundaries')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(S.SALE_DATE) >= '2019-01-01' AND MAX(S.SALE_DATE) < '2019-03-31';

/*
Prediction Result:
(10, 'StartBoundaryOnly')
*/