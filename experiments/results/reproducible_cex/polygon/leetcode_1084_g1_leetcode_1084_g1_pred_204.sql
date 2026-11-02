-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (17, '24', 1);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (24, NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (24, 22, 23, NULL, 1, 853);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(24, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM (SELECT PRODUCT_ID, MAX(SALE_DATE) AS LO, MIN(SALE_DATE) AS HI FROM SALES GROUP BY PRODUCT_ID HAVING MAX(SALE_DATE) <= '2019-03-31' AND MIN(SALE_DATE) >= '2019-01-01') AS T CROSS JOIN PRODUCT AS P WHERE T.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
*/