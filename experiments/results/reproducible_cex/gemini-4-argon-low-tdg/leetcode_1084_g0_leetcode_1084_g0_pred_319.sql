-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact lower and upper date boundaries ('2019-01-01' and '2019-03-31'), and multiple sales in range (kills missing DISTINCT if using simple JOIN instead of GROUP BY/IN).
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'Prod_Exact_Boundaries', 100);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (2, 'Prod_Mid_Range_Multi', 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 10, 20, '2019-01-01', 1, 100);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 10, 21, '2019-03-31', 2, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 11, 22, '2019-02-15', 1, 200);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (2, 11, 23, '2019-02-20', 3, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'Prod_Exact_Boundaries')
(2, 'Prod_Mid_Range_Multi')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM SALES NATURAL JOIN PRODUCT WHERE SALE_DATE < '2019-03-31' AND SALE_DATE > '2019-01-01' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') GROUP BY PRODUCT_ID;

/*
Prediction Result:
(2, 'Prod_Mid_Range_Multi')
*/