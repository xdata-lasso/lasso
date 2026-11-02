-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, NULL), (0, NULL, 1), (-1, 'default2', 1), (1, 'default2', 1), (3, 'default2', NULL), (4, 'default1', 1), (5, '2019-01-01', 1), (6, '2019-03-31', NULL), (7, 'default2', 2), (8, '2019-01-01', 2), (9, 'default2', NULL), (10, 'default1', 1), (11, NULL, 1), (12, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, -1, NULL, NULL, 1), (10, 1, NULL, '2019-01-01', NULL, 2), (0, 2, 1, NULL, 1, NULL), (6, 1, NULL, '2023-01-02', 1, NULL), (3, 1, 2, '2019-03-31', NULL, NULL), (12, 1, 0, '2018-12-31', 2, 2), (10, 1, NULL, '2018-12-31', 2, NULL), (12, 2, -1, '2023-01-01', 2, 2), (8, NULL, 2, NULL, 1, NULL), (8, NULL, 1, '2019-03-31', 1, NULL), (5, 2, NULL, '2019-03-30', NULL, NULL), (6, 1, -1, '2018-12-31', 1, 1), (9, 2, NULL, '2023-01-02', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(3, 'default2')
(5, '2019-01-01')
(8, '2019-01-01')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
(3, 'default2')
(5, '2019-01-01')
*/