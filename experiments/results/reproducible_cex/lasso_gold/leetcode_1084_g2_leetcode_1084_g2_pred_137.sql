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
SELECT DISTINCT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A INNER JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01');

/*
Prediction Result:
*/