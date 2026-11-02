-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'default2', 1), (2, '2019-03-31', NULL), (3, NULL, 1), (4, 'default1', NULL), (5, 'default2', NULL), (6, '2019-01-01', 1), (7, NULL, 1), (8, 'default1', NULL), (9, '2019-01-01', NULL), (10, '2019-03-31', 1), (11, 'default1', 1), (12, '2019-01-01', 1), (13, NULL, 1), (14, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, NULL, 0, '2019-01-01', NULL, NULL), (3, NULL, 0, NULL, NULL, 1), (4, 0, 1, '2023-01-01', NULL, NULL), (NULL, 1, 0, '2019-01-02', NULL, 1), (7, 1, 0, NULL, 1, NULL), (10, 1, 0, '2019-03-31', NULL, NULL), (0, NULL, 1, '2019-01-02', NULL, 1), (10, 1, 1, '2019-04-01', NULL, NULL), (10, 1, NULL, '2019-01-01', NULL, 1), (14, 1, 0, '2018-12-31', NULL, 1), (NULL, NULL, 0, '2019-04-01', NULL, 1), (7, NULL, 0, '2023-01-01', 1, 1), (13, 1, NULL, '2019-03-31', NULL, 1), (8, 1, 1, '2019-03-31', NULL, 1), (8, 1, 1, '2023-01-02', 1, 1), (12, NULL, NULL, '2019-04-01', 1, NULL), (6, NULL, NULL, '2019-03-30', NULL, 1), (2, 1, 0, '2019-03-30', 1, NULL), (1, 1, 0, '2019-03-30', 1, 1), (2, NULL, 0, '2019-04-01', 1, NULL), (NULL, NULL, NULL, '2019-01-02', NULL, 1), (11, 0, NULL, NULL, 1, NULL), (14, 1, NULL, '2019-03-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT EXISTS(SELECT PRODUCT_ID FROM SALES WHERE PRODUCT_ID = P.PRODUCT_ID AND (SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31'));

/*
Prediction Result:
(0, 'default2')
(13, None)
(6, '2019-01-01')
(1, 'default2')
*/