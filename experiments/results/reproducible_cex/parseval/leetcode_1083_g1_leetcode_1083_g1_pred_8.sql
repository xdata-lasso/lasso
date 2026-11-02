-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'S8', 13244799);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'pro_bd3179', 1526238907);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1980249628, 1, '2022-10-19', 1871297066, 809183447);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 906324270, 1, '2020-05-06', 2122220075, 1072996612);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1823627488, 1, '2023-09-04', 1861536320, 44952191);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1151980946, 1, '2020-12-06', 1038707349, 1419861592);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 528680845, 1, '2025-03-28', 1155439218, 1313172851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1106983592, 1, '2023-03-15', 902551284, 2107872094);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1068298341, 1, '2024-10-16', 2074205376, 274769912);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -975213201, 1, '2021-01-15', 222415430, 556727997);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 176555546, NULL, '2020-11-04', 1196308825, 910894705);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1070063173, 1, '2024-02-11', 722884590, 580968159);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT S1.BUYER_ID FROM SALES AS S1 CROSS JOIN PRODUCT AS P WHERE S1.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT S1.BUYER_ID AS IPHONE FROM SALES AS S1 CROSS JOIN PRODUCT AS P WHERE S1.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(1,)
(None,)
*/