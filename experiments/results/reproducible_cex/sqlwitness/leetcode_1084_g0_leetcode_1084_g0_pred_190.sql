-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, '2019-03-31', NULL), (2, NULL, 1), (3, 'default2', 1), (4, '2019-01-01', 1), (5, '2019-03-31', 1), (6, 'default2', NULL), (7, 'default1', NULL), (8, 'default1', 1), (9, 'default1', 1), (10, '2019-03-31', NULL), (11, '2019-03-31', NULL), (12, 'default1', 1), (13, 'default1', 1), (14, '2019-03-31', 1), (15, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, 1, 0, '2019-01-01', NULL, 1), (5, 0, 0, '2019-04-01', NULL, NULL), (11, NULL, 0, '2019-01-01', NULL, NULL), (15, NULL, 1, '2023-01-02', NULL, 1), (0, 0, NULL, '2023-01-01', NULL, 1), (14, 1, 1, '2019-01-01', NULL, 1), (4, 0, NULL, NULL, NULL, NULL), (15, 0, 1, '2019-03-31', 1, NULL), (2, NULL, NULL, '2023-01-02', 1, NULL), (7, NULL, 0, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(7, 'default1')
(11, '2019-03-31')
(14, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT (SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'));

/*
Prediction Result:
(14, '2019-03-31')
(11, '2019-03-31')
(4, '2019-01-01')
(7, 'default1')
*/