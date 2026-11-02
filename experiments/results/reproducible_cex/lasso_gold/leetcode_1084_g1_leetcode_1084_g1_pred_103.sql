-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1164, 'Patty Perez', 1165);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1171, 'Patty Perez', 1165);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1180, 'Tommy Walter', 1181);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1187, 'Tommy Walter', 1181);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1164, 1166, 1167, '2019-02-14', 1168, 1169);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1164, 1174, 1175, '2019-02-15', 1176, 1177);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1180, 1182, 1183, '2019-02-14', 1184, 1185);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1164, 'Patty Perez')
(1180, 'Tommy Walter')
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_ID, (CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 1 ELSE 0 END) AS SPRING_SALE FROM SALES), B AS (SELECT PRODUCT_ID, SUM(SPRING_SALE) AS SPRING_SALE, COUNT(*) AS TOTAL FROM A GROUP BY PRODUCT_ID HAVING SPRING_SALE <> 0 AND TOTAL = SPRING_SALE) SELECT B.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM B JOIN PRODUCT ON B.PRODUCT_ID = PRODUCT.PRODUCT_ID;

/*
Prediction Result:
(1180, 'Tommy Walter')
*/