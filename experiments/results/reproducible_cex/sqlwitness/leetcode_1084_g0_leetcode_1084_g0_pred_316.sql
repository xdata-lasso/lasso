-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 2), (2, 'default2', 1), (1, '2019-03-31', NULL), (3, 'default1', 1), (4, NULL, NULL), (5, 'default2', 1), (6, '2019-03-31', NULL), (7, 'default1', 2), (8, 'default2', 1), (9, '2019-03-31', 2), (10, NULL, 2), (11, NULL, 1), (12, 'default1', 1), (13, 'default2', 2), (14, 'default2', 1), (15, '2019-01-01', 1), (16, NULL, 2), (17, '2019-03-31', NULL), (18, 'default2', 1), (19, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, 2, NULL, 2, 2), (10, 0, 0, '2019-03-30', NULL, 1), (14, 1, 2, '2019-03-31', 1, 2), (16, 1, 0, '2019-03-30', 1, 2), (NULL, 0, 1, '2019-01-02', 2, 1), (16, 0, 2, NULL, 2, 1), (18, NULL, 1, '2018-12-31', 2, NULL), (16, 2, 2, '2019-03-31', NULL, NULL), (18, 2, 1, NULL, NULL, 1), (5, 1, 2, '2019-01-02', NULL, 1), (14, 2, 1, '2023-01-01', 1, 1), (15, 2, NULL, '2019-01-01', 2, 1), (19, 2, NULL, '2019-04-01', NULL, 1), (16, 2, NULL, '2019-03-31', 2, 1), (11, 1, 0, '2019-03-30', NULL, 1), (0, 2, 2, '2023-01-01', 2, 2), (5, 1, 2, '2019-01-02', NULL, NULL), (9, 2, NULL, '2023-01-02', 1, 1), (NULL, 2, 2, '2019-01-02', 1, 1), (NULL, 1, NULL, '2019-04-01', NULL, NULL), (9, NULL, 2, '2023-01-01', NULL, NULL), (9, NULL, 0, '2019-04-01', 1, NULL), (13, 2, NULL, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(5, 'default2')
(10, None)
(11, None)
(15, '2019-01-01')
(16, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY 1 HAVING COUNT(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN PRODUCT_ID END) = COUNT(PRODUCT_ID));

/*
Prediction Result:
(5, 'default2')
(10, None)
(11, None)
(15, '2019-01-01')
*/