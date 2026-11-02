-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 1), (0, '2019-03-31', 1), (2, 'default2', NULL), (3, '2019-01-01', NULL), (4, NULL, 1), (5, 'default2', NULL), (6, 'default1', 1), (7, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 0, '2023-01-01', 1, 1), (5, NULL, 0, '2019-04-01', NULL, 1), (5, 1, NULL, '2019-01-02', NULL, NULL), (5, 1, NULL, '2023-01-01', 1, NULL), (7, 1, 0, '2023-01-02', NULL, NULL), (NULL, NULL, 1, '2018-12-31', NULL, 1), (5, 1, 0, '2018-12-31', NULL, 1), (5, 0, 1, '2019-01-02', 1, 1), (6, 0, NULL, NULL, NULL, NULL), (5, 0, NULL, '2019-04-01', 1, NULL), (2, 0, 0, '2023-01-01', NULL, NULL), (1, NULL, 0, '2019-03-30', 1, NULL), (3, NULL, NULL, '2019-04-01', 1, NULL), (4, 0, 1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT A.PRODUCT_ID, A.SALE_DATE, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM CTE WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM CTE WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM CTE WHERE (SALE_DATE < '2019-01-01') OR (SALE_DATE > '2019-03-31')) GROUP BY PRODUCT_ID, PRODUCT_NAME;

/*
Prediction Result:
(1, '2019-03-31')
*/