-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 247012447);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -106629402, 1, '2021-02-11', 809183447, 89267185);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 700293388, 1, '2023-11-30', 1908028688, 2122220075);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1236688122, NULL, '2022-02-26', 907682809, 2026480202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH S8_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), I_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'), S8_BUYER AS (SELECT SALES.BUYER_ID FROM S8_ID CROSS JOIN SALES WHERE SALES.PRODUCT_ID = S8_ID.PRODUCT_ID), I_BUYER AS (SELECT SALES.BUYER_ID FROM I_ID CROSS JOIN SALES WHERE SALES.PRODUCT_ID = I_ID.PRODUCT_ID) SELECT DISTINCT (S8_BUYER.BUYER_ID) FROM S8_BUYER WHERE NOT S8_BUYER.BUYER_ID IN (SELECT BUYER_ID FROM I_BUYER);

/*
Prediction Result:
(None,)
(1,)
*/