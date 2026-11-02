-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (12, NULL, NULL);
INSERT INTO "Product" ("product_id", "product_name", "unit_price") VALUES (11, '17', NULL);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (NULL, NULL, NULL, '2019-01-01', NULL, 1);
INSERT INTO "Sales" ("product_id", "seller_id", "buyer_id", "sale_date", "quantity", "price") VALUES (11, NULL, 21, '2019-04-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT NNEW.PRODUCT_ID, NNEW.PRODUCT_NAME FROM (SELECT NEW.PRODUCT_ID, NEW.PRODUCT_NAME, MAX(NEW.SALE_DATE), MIN(NEW.SALE_DATE) FROM (SELECT SALES.PRODUCT_ID, PRODUCT_NAME, SALE_DATE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) AS NEW GROUP BY NEW.PRODUCT_ID, NEW.PRODUCT_NAME HAVING MAX(NEW.SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31' AND MIN(NEW.SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31') AS NNEW;

/*
Prediction Result:
(None, None)
*/