-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-01-01', 2), (-1, '2019-03-31', NULL), (0, NULL, 1), (1, '2019-01-01', 2), (3, '2019-01-01', 2), (4, '2019-01-01', 2), (5, '2019-01-01', 2), (6, '2019-03-31', 2), (7, NULL, 1), (8, NULL, 2), (9, NULL, 1), (10, '2019-01-01', 1), (11, '2019-03-31', NULL), (12, 'default2', NULL), (13, '2019-01-01', NULL), (14, 'default1', 2), (15, '2019-01-01', 1), (16, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, -1, -1, '2019-03-31', 1, 2), (10, NULL, -1, NULL, 2, NULL), (16, -1, 2, '2019-03-31', 1, NULL), (NULL, -1, 2, '2018-12-31', NULL, 1), (9, 1, 0, '2023-01-01', 2, 1), (1, 1, 1, '2019-01-01', 1, NULL), (6, 0, 1, '2023-01-02', 2, 2), (5, NULL, -1, '2019-01-02', 1, 2), (12, NULL, 0, '2023-01-02', 1, 1), (2, -1, -1, '2019-01-01', 1, NULL), (0, 1, NULL, '2019-03-30', 1, NULL), (11, 2, -1, '2019-03-31', NULL, NULL), (6, 0, 2, '2019-04-01', 1, NULL), (11, 1, -1, NULL, NULL, NULL), (11, 1, -1, '2018-12-31', 1, NULL), (15, 0, 1, '2019-03-30', 2, 1), (11, 1, 1, '2019-01-01', 1, NULL), (NULL, 2, -1, '2019-04-01', 2, NULL), (13, NULL, 2, '2018-12-31', NULL, 1), (-1, NULL, 0, '2019-01-01', 2, 2), (4, 1, -1, NULL, 2, NULL), (2, 1, 1, NULL, NULL, 1), (10, NULL, 1, '2019-03-30', 1, 1), (10, 2, NULL, '2019-01-02', NULL, 1), (16, 1, 1, '2019-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, '2019-03-31')
(0, None)
(1, '2019-01-01')
(2, '2019-01-01')
(5, '2019-01-01')
(10, '2019-01-01')
(15, '2019-01-01')
(16, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING AVG(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) = 1);

/*
Prediction Result:
(-1, '2019-03-31')
(0, None)
(1, '2019-01-01')
(5, '2019-01-01')
(15, '2019-01-01')
(16, None)
*/