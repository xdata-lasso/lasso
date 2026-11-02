-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1049, 'Gabrielle Davis', 1050);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1049, 1051, 1052, '2019-03-31 12:00:00', 1053, 1054);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-04-1' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE <= '2018-12-31') AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-4-1') GROUP BY S.PRODUCT_ID;

/*
Prediction Result:
(1049, 'Gabrielle Davis')
*/