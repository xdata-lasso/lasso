-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (18, '19', 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, 25, NULL, '2019-01-01', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (18, NULL, 23, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(18, '19')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT A.PRODUCT_ID IN (SELECT A.PRODUCT_ID FROM SALES AS A WHERE NOT A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(None, None)
(18, '19')
*/