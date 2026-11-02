-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (2, NULL, NULL), (-1, NULL, NULL), (0, '2019-01-01', 2), (3, NULL, 1), (4, 'default1', 1), (5, NULL, NULL), (6, 'default2', NULL), (7, '2019-01-01', 2), (8, 'default1', 1), (9, NULL, NULL), (10, 'default2', NULL), (11, 'default1', 2), (12, '2019-03-31', NULL), (13, '2019-01-01', 1), (14, 'default1', 1), (15, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, -1, 0, '2019-03-31', 1, NULL), (0, -1, 0, '2019-01-02', 2, 1), (5, NULL, NULL, '2018-12-31', NULL, 1), (1, 2, 1, '2023-01-02', NULL, 1), (10, 2, NULL, '2019-03-30', 1, NULL), (9, 0, 0, '2019-03-31', NULL, 1), (3, 1, 0, '2023-01-02', 1, 2), (NULL, 2, -1, '2023-01-02', NULL, 2), (4, 0, -1, '2019-04-01', NULL, 1), (-1, NULL, -1, '2018-12-31', 2, 1), (12, NULL, 1, '2019-03-30', 1, 1), (1, 0, NULL, NULL, 2, 2), (11, 2, 2, '2019-03-31', 2, 2), (10, 1, 0, NULL, NULL, NULL), (0, -1, 1, '2019-03-31', NULL, 2), (2, 2, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, '2019-01-01')
(6, 'default2')
(9, None)
(10, 'default2')
(11, 'default1')
(12, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) GROUP BY P.PRODUCT_ID HAVING SUM(CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
(0, '2019-01-01')
(6, 'default2')
(9, None)
(11, 'default1')
(12, '2019-03-31')
*/