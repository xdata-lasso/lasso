-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (-1, '2019-01-01', NULL), (0, '2019-01-01', 2), (1, '2019-03-31', NULL), (3, '2019-03-31', 1), (4, '2019-03-31', NULL), (5, '2019-01-01', 2), (6, 'default1', 1), (7, NULL, 2), (8, NULL, 1), (9, 'default2', 2), (10, '2019-03-31', NULL), (11, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 2, NULL, NULL, 2), (1, 1, 1, '2019-03-30', NULL, 1), (NULL, 0, -1, '2019-04-01', 1, 1), (NULL, -1, -1, '2019-01-02', 1, NULL), (8, NULL, -1, '2023-01-01', 1, 2), (2, NULL, 1, '2019-01-02', NULL, 2), (9, 2, NULL, '2019-04-01', 1, 2), (5, 0, NULL, '2019-04-01', NULL, NULL), (9, NULL, 2, '2019-03-30', 2, 1), (1, NULL, NULL, '2018-12-31', NULL, 1), (-1, 0, 2, NULL, NULL, NULL), (0, 2, NULL, '2018-12-31', 1, 1), (4, 1, -1, NULL, 1, 1), (6, -1, 1, '2018-12-31', NULL, 1), (2, 2, 1, '2019-01-02', 1, NULL), (10, -1, NULL, '2019-03-30', 2, 1), (1, NULL, 0, '2019-01-01', NULL, 2), (-1, 2, 1, '2019-03-30', 2, 2), (5, 1, 2, '2019-03-31', 1, 2), (4, -1, 1, '2019-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, '2019-01-01')
(2, None)
(4, '2019-03-31')
(10, '2019-03-31')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
(2, None)
(10, '2019-03-31')
*/