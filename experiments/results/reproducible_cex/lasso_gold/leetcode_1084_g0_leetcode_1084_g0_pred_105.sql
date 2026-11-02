-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1019, 'Daniel Wagner', 1020);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1025, 'Cristian Santos', 1026);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1036, 'Connie Lawrence', 1031);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1019, 1021, 1022, '2019-02-14', 1023, 1024);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1025, 1027, 1028, NULL, 1029, 1030);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1025, 1032, 1033, '2019-02-14', 1034, 1035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1019, 'Daniel Wagner')
(1025, 'Cristian Santos')
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SUM(QUANTITY) AS TOTAL_SOLD, SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN QUANTITY ELSE 0 END) AS SOLD_SPRING FROM SALES GROUP BY 1) SELECT C.PRODUCT_ID, P.PRODUCT_NAME FROM CTE AS C JOIN PRODUCT AS P ON C.PRODUCT_ID = P.PRODUCT_ID WHERE TOTAL_SOLD = SOLD_SPRING;

/*
Prediction Result:
(1019, 'Daniel Wagner')
*/