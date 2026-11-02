-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1215, 'Stephanie Ross', 1216);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1222, 'Stephanie Ross', 1216);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1228, 'Zachary Hicks', 1223);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1215, 1217, 1218, '2019-02-14', 1219, 1220);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 1224, 1225, '2019-04-01', 1226, 1227);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1215, 'Stephanie Ross')
*/

-- Prediction Query
WITH TABLE_FINAL AS (SELECT A.PRODUCT_ID, PRODUCT_NAME, SALE_DATE FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM TABLE_FINAL WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM TABLE_FINAL WHERE '2019-01-01' <= SALE_DATE <= '2019-03-31') AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM TABLE_FINAL WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/