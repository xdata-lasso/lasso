-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, -1, NULL, '2019-01-01', NULL, NULL), (NULL, 0, 2, '2019-03-30', 2, NULL), (NULL, 2, -1, '2023-01-01', 1, 2), (NULL, 0, 2, '2019-04-01', 2, NULL), (NULL, -1, 1, '2019-03-30', 1, 2), (1, 1, NULL, '2023-01-02', NULL, NULL), (1, 1, 2, '2019-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SUM(QUANTITY) AS TOTAL_SOLD, SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN QUANTITY ELSE 0 END) AS SOLD_SPRING FROM SALES GROUP BY 1) SELECT C.PRODUCT_ID, P.PRODUCT_NAME FROM CTE AS C JOIN PRODUCT AS P ON C.PRODUCT_ID = P.PRODUCT_ID WHERE TOTAL_SOLD = SOLD_SPRING;

/*
Prediction Result:
(1, '2019-03-31')
*/