-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1269, 'Sherri Baker', 1270);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1276, 'Sherri Baker', 1270);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1277, 'Cassandra Gaines', 1278);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1284, 'Cassandra Gaines', 1278);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1269, 1271, 1272, '2019-02-14', 1273, 1274);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1277, 1279, 1280, NULL, 1281, 1282);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1269, 'Sherri Baker')
(1277, 'Cassandra Gaines')
*/

-- Prediction Query
SELECT P.PRODUCT_NAME, S.PRODUCT_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY S.PRODUCT_ID ORDER BY S.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
('Sherri Baker', 1269)
*/