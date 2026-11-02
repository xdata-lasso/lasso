-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, '2019-03-31', NULL), (2, '2019-01-01', 1), (3, NULL, NULL), (4, '2019-01-01', 1), (5, '2019-01-01', 1), (6, 'default1', NULL), (7, '2019-03-31', NULL), (8, 'default2', NULL), (9, NULL, NULL), (10, 'default1', NULL), (11, '2019-03-31', 1), (12, '2019-01-01', 1), (13, 'default1', NULL), (14, 'default2', 1), (15, 'default1', 1), (16, '2019-03-31', 1), (17, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, NULL, '2019-03-31', NULL, 1), (7, NULL, 0, '2019-01-02', NULL, 1), (1, NULL, 1, '2019-01-01', NULL, NULL), (7, NULL, 0, NULL, 1, NULL), (13, NULL, NULL, '2019-01-01', 1, 1), (6, 0, NULL, '2019-04-01', NULL, NULL), (10, NULL, NULL, '2023-01-01', 1, NULL), (15, 1, NULL, '2019-01-02', NULL, 1), (3, 1, NULL, NULL, 1, 1), (12, 1, 0, '2023-01-01', NULL, 1), (10, NULL, NULL, '2019-03-31', 1, 1), (8, NULL, NULL, '2023-01-01', 1, NULL), (0, NULL, NULL, '2019-04-01', NULL, NULL), (13, 1, NULL, '2019-01-02', 1, NULL), (10, 0, 1, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(7, '2019-03-31')
(1, 'default1')
(13, 'default1')
(15, 'default1')
(3, None)
*/

-- Prediction Query
WITH TB AS (SELECT S.*, P.PRODUCT_NAME, P.UNIT_PRICE FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM TB WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM TB WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(7, '2019-03-31')
(1, 'default1')
(13, 'default1')
(15, 'default1')
*/