-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, '2019-01-01', 1), (2, 'default2', NULL), (3, '2019-03-31', 1), (4, '2019-03-31', NULL), (5, '2019-01-01', 1), (6, '2019-01-01', 1), (7, '2019-03-31', NULL), (8, NULL, 1), (9, NULL, NULL), (10, NULL, NULL), (11, '2019-01-01', 1), (12, NULL, NULL), (13, '2019-03-31', 1), (14, '2019-01-01', 1), (15, '2019-01-01', NULL), (16, '2019-03-31', NULL), (17, '2019-03-31', NULL), (18, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 0, '2023-01-01', NULL, 1), (17, NULL, NULL, '2023-01-02', NULL, NULL), (11, NULL, 0, '2019-01-02', NULL, NULL), (6, 0, 0, '2019-03-30', 1, 1), (7, NULL, NULL, '2019-01-01', NULL, NULL), (18, 0, 0, '2019-01-01', 1, 1), (14, 1, 0, NULL, 1, NULL), (15, 0, 1, '2019-03-31', NULL, 1), (7, 1, 1, '2019-04-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(11, '2019-01-01')
(6, '2019-01-01')
(18, '2019-03-31')
(14, '2019-01-01')
(15, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, (SELECT PRODUCT_NAME FROM PRODUCT WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID) AS PRODUCT_NAME FROM SALES WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(11, '2019-01-01')
(6, '2019-01-01')
(18, '2019-03-31')
(15, '2019-01-01')
*/