-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'pro_bd3179', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_7314f1', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 546571701);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (4, 'pro_bd3179', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (5, 'pro_bd3179', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (6, 'pro_bd3179', 1861536320);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (7, 'pro_bd3179', 44952191);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1633151678, -252690330, NULL, 1115440883, 1644814318);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -845863578, -1610064545, NULL, 429706943, 462974032);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1861536320, 44952191, NULL, 1151980946, 1620389964);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1149850321, -1833165707, '2019-01-01', 1155439218, 1313172851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 373262291, -472966518, '2025-06-25', 1884179925, 902551284);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, -1633151678, -252690330, '2024-06-15', 1115440883, 1644814318);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (5, -845863578, -1610064545, '2024-06-15', 429706943, 462974032);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (6, 1151980946, 1620389964, '2024-06-15', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (5, 274769912, -188151580, '2024-06-15', 226938182, 90119032);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(2, 'pro_7314f1')
(1, 'pro_bd3179')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM SALES INNER JOIN PRODUCT USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(1, 'pro_bd3179')
*/