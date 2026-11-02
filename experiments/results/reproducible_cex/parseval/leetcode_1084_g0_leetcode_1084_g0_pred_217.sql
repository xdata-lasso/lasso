-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'p_s_d4e6fa', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1115440883);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1644814318, 1465859724, '2023-04-22', 700293388, 906324270);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1209887326, -1399556171, '2020-01-23', 1419861592, 700088193);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 757448742, -1179823637, '2022-04-13', 781505063, 418417917);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1031969798, -1106983592, '2023-03-15', 902551284, 2107872094);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1255852738, -1555456236, '2023-01-22', 2056419640, 222415430);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 513454646, -688216274, '2021-03-20', 1382410067, 1631231566);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1554531873, 982314585, '2023-02-18', 1038566008, 32204797);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1738458256, -1714354341, '2020-08-13', 1074760385, 1129658414);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 357330522, -683007527, '2020-06-09', 1523825314, 2078438287);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE NOT P.PRODUCT_ID IN (SELECT P2.PRODUCT_ID FROM PRODUCT AS P2 INNER JOIN SALES AS S2 ON P2.PRODUCT_ID = S2.PRODUCT_ID WHERE SALE_DATE < '2018-12-31' OR SALE_DATE > '2019-04-01');

/*
Prediction Result:
(2, 'pro_bd3179')
*/