-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (1, '2019-01-01', 1), (2, 'default2', 1), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default2', 1), (6, '2019-03-31', NULL), (7, 'default2', 1), (8, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, 0, '2019-01-02', 1, 1), (2, 1, 0, '2023-01-01', 1, 1), (NULL, 1, 1, '2019-01-01', NULL, NULL), (6, 1, NULL, NULL, 1, NULL), (2, 1, 1, '2018-12-31', NULL, 1), (3, 0, NULL, '2023-01-02', NULL, 1), (0, 0, 1, '2019-03-31', NULL, NULL), (1, 0, 1, '2019-03-31', 1, 1), (0, 1, 1, '2019-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, '2019-03-31')
(6, '2019-03-31')
(0, '2019-03-31')
(1, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(8, '2019-03-31')
(0, '2019-03-31')
(1, '2019-01-01')
*/