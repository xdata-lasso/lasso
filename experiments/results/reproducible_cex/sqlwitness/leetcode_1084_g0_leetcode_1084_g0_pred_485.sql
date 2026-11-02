-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (-1, 'default2', 2), (1, '2019-03-31', 2), (2, NULL, 2), (3, 'default2', NULL), (4, 'default1', 1), (5, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, NULL, '2019-01-01', NULL, 2), (4, -1, NULL, NULL, 2, NULL), (2, NULL, -1, '2019-04-01', 1, NULL), (NULL, 0, NULL, '2019-03-30', 2, 1), (NULL, -1, NULL, '2019-03-30', 1, 1), (2, NULL, 1, '2019-01-01', NULL, 1), (3, 2, 2, '2023-01-01', 2, NULL), (3, 1, 2, '2023-01-02', 2, 2), (4, NULL, -1, '2019-03-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
WITH TEMP AS (SELECT PRODUCT_ID, SUM(CASE WHEN NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS CASE1, SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS CASE2 FROM SALES GROUP BY PRODUCT_ID) SELECT T.PRODUCT_ID, P.PRODUCT_NAME FROM TEMP AS T LEFT JOIN PRODUCT AS P ON T.PRODUCT_ID = P.PRODUCT_ID WHERE T.CASE1 = 0 AND T.CASE2 >= 1;

/*
Prediction Result:
(None, None)
(4, 'default1')
*/