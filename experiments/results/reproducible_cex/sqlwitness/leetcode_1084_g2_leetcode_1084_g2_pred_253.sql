-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 2), (1, 'default1', NULL), (2, 'default1', 1), (-1, NULL, 2), (3, NULL, 2), (4, NULL, 2), (5, 'default1', 2), (6, NULL, 2), (7, '2019-03-31', 2), (8, 'default2', NULL), (9, 'default2', 2), (10, 'default2', NULL), (11, '2019-01-01', NULL), (12, 'default2', 2), (13, 'default2', NULL), (14, 'default1', 2), (15, '2019-03-31', NULL), (16, '2019-03-31', 1), (17, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, 0, '2019-01-01', NULL, 1), (NULL, -1, 2, '2019-01-01', 1, NULL), (10, NULL, 1, '2019-03-30', 1, 1), (9, -1, 0, '2019-04-01', 2, NULL), (6, 2, -1, '2023-01-02', 2, 2), (15, -1, 0, '2019-03-31', 1, 2), (7, -1, 2, '2018-12-31', 1, 1), (0, 0, 0, '2023-01-02', 2, 2), (7, -1, 2, '2018-12-31', 2, NULL), (16, 1, -1, '2019-03-31', 1, NULL), (10, 2, 2, '2023-01-02', 2, 2), (-1, 1, -1, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, None)
(11, '2019-01-01')
(15, '2019-03-31')
(16, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) >= 1 AND SUM(CASE WHEN NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None, None)
(-1, None)
(11, '2019-01-01')
(15, '2019-03-31')
(16, '2019-03-31')
*/