-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, 'default1', 1), (2, 'default1', NULL), (3, '2019-03-31', NULL), (4, 'default1', 1), (5, '2019-03-31', 1), (6, 'default2', 1), (7, 'default1', 1), (8, 'default1', NULL), (9, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, NULL, '2023-01-01', NULL, 1), (0, 1, 0, '2018-12-31', 1, NULL), (6, 0, NULL, '2023-01-02', NULL, 1), (7, 0, NULL, '2019-04-01', 1, 1), (4, 1, 1, '2019-01-01', NULL, NULL), (6, NULL, NULL, '2019-04-01', NULL, 1), (5, NULL, NULL, NULL, 1, NULL), (8, NULL, NULL, '2019-04-01', NULL, NULL), (6, 0, 1, '2019-04-01', NULL, NULL), (2, 0, NULL, '2019-01-01', 1, 1), (3, 0, NULL, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, 'default1')
(5, '2019-03-31')
(2, 'default1')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(4, 'default1')
(2, 'default1')
*/