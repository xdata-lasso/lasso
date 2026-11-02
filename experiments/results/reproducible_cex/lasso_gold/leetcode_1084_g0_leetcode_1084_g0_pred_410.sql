-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "unit_price") VALUES (1013, 'Angie Henderson', 1014);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1013, 1015, 1016, '2019-03-31', 1017, 1018);
INSERT INTO "sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (1013, 1015, 1016, '2019-03-31', 1017, 1018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1013, 'Angie Henderson')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING GROUP_CONCAT(SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
*/