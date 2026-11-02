-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1304, 'S8', 1305);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1314, 'S8', 1305);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1326, 'iPhone', 1327);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1336, 'iPhone', 1327);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1304, 1306, 1307, '1995-11-09', 1308, 1309);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1304, 1310, 1307, '1996-01-10', 1311, 1312);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1326, 1328, 1329, '1970-04-13', 1330, 1331);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1326, 1332, 1329, '1971-05-14', 1333, 1334);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1307,)
*/

-- Prediction Query
SELECT DISTINCT SALES.BUYER_ID FROM SALES WHERE SALES.BUYER_ID IN (SELECT B.BUYER_ID FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME = 'S8') AND NOT SALES.BUYER_ID IN (SELECT B.BUYER_ID FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/