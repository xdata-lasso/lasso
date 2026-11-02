-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 1000);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'G4', 800);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (3, 'iPhone', 1400);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (4, 'UnsoldItem', 500);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2019-01-21', 2, 2000);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 2, '2019-02-17', 1, 1000);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 2, 1, '2019-02-17', 1, 800);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 2, 3, '2019-06-01', 1, 800);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 3, 2, '2018-11-11', 1, 1400);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 3, 3, '2019-01-15', 1, 1400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'S8')
*/

-- Prediction Query
SELECT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A WHERE NOT A.PRODUCT_ID IN (SELECT C.PRODUCT_ID FROM SALES AS C WHERE C.SALE_DATE > '2019-03-31' OR C.SALE_DATE < '2019-01-01');

/*
Prediction Result:
(1, 'S8')
(4, 'UnsoldItem')
*/