-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'p_s_3810e8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1115440883);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (4, 'pro_bd3179', 1644814318);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (5, 'pro_bd3179', 1465859724);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (6, 'pro_bd3179', 1019800248);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (7, 'pro_bd3179', 429706943);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (8, 'pro_bd3179', 462974032);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (9, 'pro_bd3179', 1861536320);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (10, 'pro_bd3179', 44952191);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (11, 'pro_bd3179', 1151980946);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME;

/*
Prediction Result:
(1, 'p_s_3810e8')
(2, 'pro_bd3179')
(3, 'pro_bd3179')
(4, 'pro_bd3179')
(5, 'pro_bd3179')
(6, 'pro_bd3179')
(7, 'pro_bd3179')
(8, 'pro_bd3179')
(9, 'pro_bd3179')
(10, 'pro_bd3179')
(11, 'pro_bd3179')
*/