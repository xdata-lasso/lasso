-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, NULL, 1), (2, 'default1', 1), (3, '2019-03-31', NULL), (4, '2019-03-31', 1), (5, '2019-03-31', 1), (6, '2019-03-31', NULL), (7, 'default1', 1), (8, NULL, NULL), (9, 'default2', NULL), (10, 'default2', NULL), (11, 'default2', 1), (12, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, NULL, '2023-01-02', 1, 1), (3, 0, 0, '2019-01-01', NULL, 1), (2, 0, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SALE_DATE FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') SELECT CTE.PRODUCT_ID AS PRODUCT_ID, P.PRODUCT_NAME AS PRODUCT_NAME FROM CTE LEFT JOIN PRODUCT AS P ON CTE.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
(3, '2019-03-31')
*/