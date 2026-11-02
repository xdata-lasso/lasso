-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'pro_a13499', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_a13499', 1019800248);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483647, 'pro_a13499', 429706943);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (-2147483645, NULL, 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1744686505);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -252690330, 1115440883, '2019-01-01', 1644814318, 1465859724);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -45536098, 1861536320, '2019-01-01', 44952191, 1151980946);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1620389964, 546571701, '2019-01-01', 947159877, 1990080517);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1673584235, -2118135981, '2019-01-01', 2074205376, 274769912);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 222415430, 556727997, '2019-01-01', 1178000634, 1836127587);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 906324270, 1908028688, '2020-03-30', 1072996612, 13244799);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'pro_a13499')
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_ID, (CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 1 ELSE 0 END) AS SPRING_SALE FROM SALES), B AS (SELECT PRODUCT_ID, SUM(SPRING_SALE) AS SPRING_SALE, COUNT(*) AS TOTAL FROM A GROUP BY PRODUCT_ID HAVING SPRING_SALE <> 0 AND TOTAL = SPRING_SALE) SELECT B.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM B JOIN PRODUCT ON B.PRODUCT_ID = PRODUCT.PRODUCT_ID;

/*
Prediction Result:
*/