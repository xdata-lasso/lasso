-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Product A', 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, NULL, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'Product A')
*/

-- Prediction Query
SELECT DISTINCT (P2.PRODUCT_ID), P2.PRODUCT_NAME FROM PRODUCT AS P2 JOIN SALES AS S2 ON P2.PRODUCT_ID = S2.PRODUCT_ID WHERE NOT P2.PRODUCT_ID IN (SELECT P1.PRODUCT_ID FROM PRODUCT AS P1 JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE NOT S1.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND S2.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
*/