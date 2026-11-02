-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1, 'S8', 247012447);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (3, 'S8', 1744686505);

INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (2, 'pro_bd3179', 1115440883);

-- Inserting into table: sales --
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, NULL, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, NULL, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, NULL, 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, NULL);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', NULL, 1);

INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, '2024-06-15', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.*, CASE WHEN P.PRODUCT_NAME = 'S8' THEN 0 WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE NULL END AS N_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE NOT N_ID IS NULL GROUP BY BUYER_ID HAVING SUM(N_ID) = 0;

/*
Prediction Result:
(None,)
(1,)
*/