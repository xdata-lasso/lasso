-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1009, 'Noah Rhodes', 1010);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1016, 'Noah Rhodes', 1010);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1009, 1011, 1012, '2019-02-14', 1013, 1014);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1009, 1018, 1019, '2018-12-31', 1020, 1021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-01-01' AND SALE_DATE < '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2018-12-31' OR SALE_DATE > '2019-04-01')) AS A ON P.PRODUCT_ID = A.PRODUCT_ID;

/*
Prediction Result:
(1009, 'Noah Rhodes')
*/