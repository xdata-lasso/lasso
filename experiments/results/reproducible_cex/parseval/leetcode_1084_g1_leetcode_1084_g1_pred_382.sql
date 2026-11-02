-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'pro_bd3179', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (4, 'pro_bd3179', 700088193);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (5, 'pro_bd3179', 374105386);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (6, 'pro_bd3179', 602161869);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (7, 'pro_bd3179', 1350414441);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -252690330, 1115440883, NULL, 1644814318, 1465859724);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 44952191, 1151980946, NULL, 1620389964, 546571701);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1149850321, -1833165707, NULL, 1155439218, 1313172851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1633151678, -252690330, '1970-01-01', 1115440883, 1644814318);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1610064545, 429706943, '2022-09-14', 1236688122, 2087640001);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -1209887326, -1399556171, '1970-01-02', 1038707349, 1419861592);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, -1106983592, 1884179925, '1970-01-01', 902551284, 2107872094);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (5, 1255852738, -1555456236, '2023-01-22', 2056419640, 222415430);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, -2078052421, -512640349, '1970-01-02', 1038566008, 32204797);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (4, -1478247928, 1074760385, '2024-06-15', 1129658414, 1250290042);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (6, -1717646459, -1696173285, '2024-06-15', 710458518, 678047687);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'pro_bd3179')
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID AS PRODUCT_ID, PRODUCT.PRODUCT_NAME AS PRODUCT_NAME FROM PRODUCT LEFT JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY SALES.PRODUCT_ID HAVING MIN(SALES.SALE_DATE) >= '2019-01-01' AND MAX(SALES.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
*/