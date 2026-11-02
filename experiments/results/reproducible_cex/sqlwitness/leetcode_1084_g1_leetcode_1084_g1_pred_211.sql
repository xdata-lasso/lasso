-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (1, 'default1', NULL), (0, '2019-03-31', 1), (3, '2019-03-31', 2), (4, 'default1', NULL), (5, '2019-01-01', 2), (6, '2019-01-01', 2), (7, 'default1', 1), (8, 'default1', 1), (9, 'default2', 2), (10, 'default2', 2), (11, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, 2, '2019-01-01', NULL, 2), (3, NULL, 1, '2019-01-02', 1, 2), (1, 2, 1, '2023-01-01', NULL, NULL), (5, 0, NULL, '2019-04-01', NULL, 1), (9, 1, 2, '2018-12-31', 1, NULL), (11, NULL, NULL, '2023-01-02', NULL, NULL), (0, 1, NULL, NULL, 1, NULL), (9, 2, 1, '2019-04-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, '2019-03-31')
(0, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE (P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31')) AND (NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31')) GROUP BY 1;

/*
Prediction Result:
(3, '2019-03-31')
*/