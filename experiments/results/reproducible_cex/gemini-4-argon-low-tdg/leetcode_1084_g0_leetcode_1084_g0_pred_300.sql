-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests products that have sales BOTH inside the target range and outside the target range (kills queries using WHERE sale_date BETWEEN ... without excluding products sold outside the range).
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Prod_In_And_Before', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'Prod_In_And_After', 200);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (3, 'Prod_Before_In_After', 300);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (4, 'Prod_Strictly_In', 400);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 10, 20, '2018-12-31', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 10, 21, '2019-01-15', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 11, 22, '2019-03-15', 1, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 11, 23, '2019-04-01', 1, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 12, 24, '2018-05-01', 1, 300);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 12, 25, '2019-02-01', 1, 300);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 12, 26, '2019-05-01', 1, 300);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, 13, 27, '2019-02-10', 1, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(4, 'Prod_Strictly_In')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES AS S GROUP BY S.PRODUCT_ID HAVING MAX(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01' AND MIN(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01');

/*
Prediction Result:
(2, 'Prod_In_And_After')
(4, 'Prod_Strictly_In')
*/