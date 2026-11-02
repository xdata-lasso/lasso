-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, NULL, NULL), (2, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, 0, '2019-03-30', 1, 1), (0, NULL, 1, NULL, NULL, NULL), (0, 1, 1, '2019-01-02', NULL, NULL), (NULL, 1, NULL, '2019-03-30', 1, 1), (1, 0, NULL, NULL, NULL, 1), (1, 1, NULL, '2019-03-31', NULL, NULL), (0, 1, NULL, '2018-12-31', 1, NULL), (2, 1, 1, '2019-03-31', NULL, NULL), (NULL, NULL, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'default2')
(2, '2019-03-31')
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID FROM SALES AS S WHERE S.SALE_DATE < '2019-01-01' OR S.SALE_DATE > '2019-03-31') SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE >= '2019-01-01' AND S.SALE_DATE <= '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT * FROM CTE);

/*
Prediction Result:
*/