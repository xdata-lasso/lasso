-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, '2019-03-31', 2), (-1, 'default2', 1), (2, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 2, 0, '2019-01-02', NULL, 1), (1, NULL, 1, '2023-01-02', 2, 2), (NULL, NULL, -1, '2019-01-02', 2, NULL), (NULL, NULL, -1, '2018-12-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN (SELECT PRODUCT_ID, SUM(FLAG) FROM (SELECT PRODUCT_ID, SALE_DATE, CASE WHEN SALE_DATE < '2019-01-01' THEN 1 WHEN SALE_DATE > '2019-03-31' THEN 1 ELSE 0 END AS FLAG FROM SALES) AS X GROUP BY PRODUCT_ID HAVING SUM(FLAG) = 0) AS Y ON P.PRODUCT_ID = Y.PRODUCT_ID;

/*
Prediction Result:
(-1, 'default2')
*/