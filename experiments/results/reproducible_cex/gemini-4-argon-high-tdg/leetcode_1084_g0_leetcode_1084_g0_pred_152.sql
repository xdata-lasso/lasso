-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 10
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, NULL, 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'NullSaleDateItem', 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, NULL, '2019-02-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 1, NULL, 1, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE (S.SALE_DATE > '2019-03-31' OR S.SALE_DATE < '2019-01-01'));

/*
Prediction Result:
(1, None)
(2, 'NullSaleDateItem')
*/