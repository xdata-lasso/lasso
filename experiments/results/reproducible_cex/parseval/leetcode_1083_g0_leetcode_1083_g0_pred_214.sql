-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'iPhone', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'S8', 1990080517);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'iPhone', 1408123494);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -106629402, 1, '2021-02-11', 809183447, 89267185);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 700293388, 1, '2023-11-30', 1908028688, 2122220075);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1236688122, 1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1038707349, 1, '2024-07-24', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 528680845, 1, '2025-03-28', 1155439218, 1313172851);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, -921187550, NULL, '2020-03-14', 2107872094, 882961052);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, 105869088, 1, '2023-12-17', 481163439, 2123196517);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (3, -975213201, 1, '2021-01-15', 222415430, 556727997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')), DEMO AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) SELECT CTE.BUYER_ID FROM CTE LEFT JOIN DEMO ON CTE.BUYER_ID = DEMO.BUYER_ID WHERE DEMO.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/