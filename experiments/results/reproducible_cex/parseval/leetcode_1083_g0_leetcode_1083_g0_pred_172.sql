-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'iPhone', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'iPhone', 1038707349);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'S8', 1419861592);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1980249628, 1, '2022-10-19', 1871297066, 809183447);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 906324270, 1, '2020-05-06', 2122220075, 1072996612);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1236688122, 1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 528680845, 1, '2025-03-28', 1155439218, 1313172851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 373262291, -472966518, '2025-06-25', 1884179925, 902551284);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -453362185, 1, '2020-03-04', 2123196517, 364869063);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -1245682094, 1, '2020-05-12', 555413010, 722884590);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 982314585, NULL, '2023-02-18', 1038566008, 32204797);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -106629402, 1, '2021-02-11', 809183447, 89267185);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 700293388, 1, '2023-11-30', 1908028688, 2122220075);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1038707349, 1, '2024-07-24', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 1408123494, 1, '2020-06-05', 700088193, 374105386);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.BUYER_ID FROM SALES AS C LEFT JOIN PRODUCT AS G ON C.PRODUCT_ID = G.PRODUCT_ID LEFT JOIN (SELECT BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') AS D ON C.BUYER_ID = D.BUYER_ID WHERE D.BUYER_ID IS NULL AND G.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(None,)
*/