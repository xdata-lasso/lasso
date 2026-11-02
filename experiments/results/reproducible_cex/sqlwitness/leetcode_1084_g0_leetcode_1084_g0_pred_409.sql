-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, '2019-03-31', 1), (-1, '2019-01-01', 1), (2, '2019-03-31', 2), (3, '2019-01-01', 2), (4, NULL, 2), (5, 'default2', NULL), (6, NULL, 2), (7, 'default1', 1), (8, 'default1', 1), (9, NULL, 1), (10, 'default1', 1), (11, '2019-01-01', NULL), (12, '2019-01-01', NULL), (13, '2019-01-01', 2), (14, '2019-01-01', 1), (15, NULL, NULL), (16, '2019-03-31', 2), (17, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (15, NULL, NULL, '2018-12-31', 2, NULL), (5, NULL, 2, '2019-03-31', 2, 2), (17, NULL, 2, '2018-12-31', 1, 1), (11, NULL, 1, '2023-01-01', NULL, 2), (2, -1, 1, '2019-01-02', NULL, 2), (5, 0, -1, '2019-03-30', 2, NULL), (12, -1, NULL, NULL, 2, 2), (3, -1, NULL, '2023-01-01', 2, 1), (-1, -1, 1, '2019-01-01', 2, 2), (4, 1, NULL, '2019-01-02', 1, 1), (11, NULL, NULL, '2019-03-30', 1, NULL), (NULL, -1, 2, '2019-03-31', 2, 2), (6, 2, NULL, '2018-12-31', 1, NULL), (2, -1, 1, '2019-01-01', 2, NULL), (14, 0, NULL, '2019-04-01', 1, NULL), (14, 0, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, '2019-01-01')
(2, '2019-03-31')
(4, None)
(5, 'default2')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(IIF(NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 0;

/*
Prediction Result:
(-1, '2019-01-01')
(2, '2019-03-31')
(4, None)
(5, 'default2')
(12, '2019-01-01')
*/