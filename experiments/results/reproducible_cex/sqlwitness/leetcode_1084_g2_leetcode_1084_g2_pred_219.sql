-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (2, 'default2', NULL), (0, '2019-03-31', NULL), (-1, 'default2', 2), (3, 'default1', NULL), (4, '2019-03-31', 2), (5, 'default1', 2), (6, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 2, '2018-12-31', NULL, NULL), (NULL, 0, 0, '2019-03-30', 1, 2), (5, NULL, 2, '2023-01-02', NULL, NULL), (0, 1, -1, '2019-03-31', 2, 2), (0, 1, 0, NULL, NULL, NULL), (6, NULL, NULL, '2018-12-31', 1, NULL), (6, 1, 2, '2019-03-30', NULL, NULL), (6, -1, NULL, '2018-12-31', 2, 2), (3, 1, NULL, '2019-03-30', 1, 1), (1, 2, -1, '2023-01-02', 2, 1), (-1, -1, 1, NULL, 2, NULL), (3, 0, 2, '2019-04-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
*/