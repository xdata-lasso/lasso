-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'default2', 1), (2, NULL, NULL), (3, '2019-01-01', NULL), (4, 'default1', NULL), (5, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 1, '2019-01-01', NULL, 1), (5, 1, 1, '2019-03-30', 1, 1), (NULL, NULL, 1, '2023-01-02', 1, 1), (0, 1, 0, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-01-01')
(5, '2019-03-31')
*/

-- Prediction Query
WITH TB AS (SELECT S.*, P.PRODUCT_NAME, P.UNIT_PRICE FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM TB WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM TB WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/