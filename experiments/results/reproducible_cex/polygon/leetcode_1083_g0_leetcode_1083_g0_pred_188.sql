-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (25, 'S8', NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (35, 'S8', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (25, 26, 27, '1000-01-29', 1, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (35, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(27,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT S2.BUYER_ID FROM SALES AS S2 JOIN (SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AS X ON X.BUYER_ID = S2.BUYER_ID WHERE NOT X.BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(27,)
*/