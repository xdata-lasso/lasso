-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1035, 'Connie Lawrence', 1036);
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1042, 'Connie Lawrence', 1036);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1035, 1037, 1038, '2019-01-01_z', 1039, 1040);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1035, 'Connie Lawrence')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE (CAST((JULIANDAY((SELECT MIN(S.SALE_DATE) FROM SALES AS S WHERE S.PRODUCT_ID = P.PRODUCT_ID)) - JULIANDAY('2019-01-01')) AS INTEGER) >= 0) AND (CAST((JULIANDAY((SELECT MAX(S.SALE_DATE) FROM SALES AS S WHERE S.PRODUCT_ID = P.PRODUCT_ID)) - JULIANDAY('2019-03-31')) AS INTEGER) <= 0);

/*
Prediction Result:
*/