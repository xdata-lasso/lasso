-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (1, 'ProdA', 10);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1, 1, 1, NULL, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'ProdA')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE > '2018-12-31' AND SALE_DATE <= '2019-03-31' AND NOT EXISTS(SELECT 1 FROM SALES AS S2 WHERE S2.PRODUCT_ID = S.PRODUCT_ID AND (S2.SALE_DATE < '2019-01-01' OR S2.SALE_DATE > '2019-03-31')) GROUP BY S.PRODUCT_ID, PRODUCT_NAME;

/*
Prediction Result:
*/