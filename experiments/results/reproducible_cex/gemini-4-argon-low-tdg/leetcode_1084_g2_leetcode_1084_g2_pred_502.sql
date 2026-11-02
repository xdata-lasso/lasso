-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'ExactLower', 10);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'ExactUpper', 20);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (3, 'ExactSpan', 30);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (4, 'JustBefore', 40);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (5, 'JustAfter', 50);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 101, 201, '2019-01-01', 1, 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 101, 201, '2019-03-31', 1, 20);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 101, 201, '2019-01-01', 1, 30);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 102, 202, '2019-03-31', 2, 60);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, 101, 201, '2018-12-31', 1, 40);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (5, 101, 201, '2019-04-01', 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, 'ExactLower')
(2, 'ExactUpper')
(3, 'ExactSpan')
*/

-- Prediction Query
SELECT * FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(1, 'ExactLower', 10, 1, 101, 201, '2019-01-01', 1, 10)
(2, 'ExactUpper', 20, 2, 101, 201, '2019-03-31', 1, 20)
(3, 'ExactSpan', 30, 3, 101, 201, '2019-01-01', 1, 30)
(3, 'ExactSpan', 30, 3, 102, 202, '2019-03-31', 2, 60)
*/