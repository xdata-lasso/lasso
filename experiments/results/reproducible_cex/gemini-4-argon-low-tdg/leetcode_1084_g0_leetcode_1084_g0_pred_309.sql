-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL sale_date handling and single-day boundary conditions (kills mutants that mishandle NULLs in MIN/MAX or WHERE clauses, or use strict < / > instead of <= / >=).
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Prod_Only_Jan1', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'Prod_Only_Mar31', 200);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (3, 'Prod_Null_Date_Only', 300);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (4, 'Prod_Valid_And_Null_Date', 400);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2019-01-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 2, '2019-03-31', 1, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1, 3, NULL, 1, 300);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, 1, 4, '2019-02-01', 1, 400);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, 1, 5, NULL, 1, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'Prod_Only_Jan1')
(2, 'Prod_Only_Mar31')
(4, 'Prod_Valid_And_Null_Date')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES AS S WHERE SALE_DATE > DATE('2019-03-31') OR SALE_DATE < DATE('2019-01-01'));

/*
Prediction Result:
(1, 'Prod_Only_Jan1')
(2, 'Prod_Only_Mar31')
(3, 'Prod_Null_Date_Only')
(4, 'Prod_Valid_And_Null_Date')
*/