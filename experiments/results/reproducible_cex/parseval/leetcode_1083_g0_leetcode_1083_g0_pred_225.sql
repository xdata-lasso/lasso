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

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1236688122, 1, '2022-02-26', 907682809, 2026480202);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1038707349, 1, '2024-07-24', 546571701, 947159877);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1408123494, 1, '2020-06-05', 700088193, 374105386);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 481163439, 1, '2023-07-07', 1909986641, 1485335077);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -953437896, 1, '2024-11-10', 392822403, 2142703426);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1555456236, 1, '2023-01-22', 2056419640, 222415430);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 982314585, 1, '2023-02-18', 1038566008, 32204797);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -7597509, 1, '2021-05-12', 1583472758, 1449284300);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1714354341, 1, '2020-08-13', 1074760385, 1129658414);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -491938169, 1, '2022-09-06', 1972233925, 1792827279);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1538707438, NULL, '2025-03-06', 1476361420, 195720193);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1732258051, 1, '2025-10-14', 1523825314, 2078438287);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1371234901, 1, '2023-12-23', 645287482, 765724008);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, -1523347137, 1, '2023-06-01', 453836040, 1467355421);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT S.BUYER_ID AS BOUGHTS8 FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'S8')), CTE2 AS (SELECT S.BUYER_ID AS BOUGHTIPHONE FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'iPhone')) SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.BUYER_ID IN (SELECT BOUGHTS8 FROM CTE1) AND NOT S.BUYER_ID IN (SELECT BOUGHTIPHONE FROM CTE2);

/*
Prediction Result:
(1,)
*/