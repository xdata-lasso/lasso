-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, '2019-01-01', 1), (2, NULL, NULL), (3, 'default1', 1), (4, 'default1', 1), (5, '2019-03-31', NULL), (6, '2019-01-01', 1), (7, '2019-03-31', NULL), (8, '2019-03-31', 1), (9, 'default2', NULL), (10, NULL, 1), (11, '2019-01-01', 1), (12, NULL, NULL), (13, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 1, '2019-04-01', NULL, 1), (11, 1, NULL, '2019-01-01', 1, NULL), (3, NULL, 0, '2019-01-02', 1, 1), (3, 0, 1, '2023-01-02', NULL, NULL), (4, 0, NULL, '2019-03-31', NULL, 1), (4, 0, NULL, '2023-01-02', 1, 1), (6, 0, NULL, '2019-03-30', 1, 1), (NULL, 1, NULL, '2023-01-01', 1, 1), (2, 1, 1, '2019-01-02', 1, 1), (3, 0, 0, '2023-01-01', 1, 1), (5, 0, NULL, '2019-03-30', NULL, 1), (6, 0, 0, '2023-01-01', NULL, 1), (11, NULL, 1, '2019-01-01', NULL, 1), (6, 1, 0, '2019-04-01', 1, NULL), (6, NULL, NULL, '2019-03-31', 1, NULL), (4, NULL, NULL, '2019-03-31', 1, NULL), (9, 1, 0, '2019-03-30', 1, NULL), (4, NULL, 1, '2023-01-01', NULL, 1), (NULL, 0, NULL, '2018-12-31', 1, NULL), (NULL, 1, 1, '2019-03-31', 1, 1), (8, 1, 0, '2023-01-01', NULL, 1), (9, 0, 1, NULL, NULL, NULL), (7, NULL, 1, '2019-01-02', 1, 1), (9, NULL, NULL, '2019-03-30', NULL, 1), (13, 0, 1, '2019-04-01', NULL, 1), (3, 0, 0, '2019-03-30', NULL, NULL), (5, 1, NULL, '2019-01-01', NULL, 1), (7, 1, NULL, '2023-01-02', 1, 1), (7, NULL, 1, '2019-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(2, None)
(5, '2019-03-31')
(9, 'default2')
(11, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT A.PRODUCT_ID IN (SELECT A.PRODUCT_ID FROM SALES AS A WHERE NOT A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/