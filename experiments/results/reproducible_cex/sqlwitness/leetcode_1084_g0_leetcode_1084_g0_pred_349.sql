-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, 'default1', NULL), (2, '2019-01-01', 1), (3, NULL, NULL), (4, 'default1', NULL), (5, 'default1', NULL), (6, 'default2', 1), (7, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, NULL, 0, '2019-01-02', NULL, 1), (4, 0, 1, '2019-04-01', 1, 1), (NULL, NULL, 0, '2019-03-30', NULL, NULL), (1, 1, 0, '2019-03-31', NULL, NULL), (5, 0, NULL, '2019-03-30', NULL, 1), (4, 1, 1, '2023-01-02', 1, 1), (2, 1, 1, '2023-01-02', 1, NULL), (NULL, NULL, NULL, '2019-01-02', 1, NULL), (1, NULL, 1, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(5, 'default1')
(7, '2019-03-31')
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SALE_DATE FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') SELECT CTE.PRODUCT_ID AS PRODUCT_ID, P.PRODUCT_NAME AS PRODUCT_NAME FROM CTE LEFT JOIN PRODUCT AS P ON CTE.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
(None, None)
(5, 'default1')
(7, '2019-03-31')
*/