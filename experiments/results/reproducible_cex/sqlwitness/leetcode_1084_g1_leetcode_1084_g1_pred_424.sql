-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (2, '2019-01-01', 1), (0, 'default1', 2), (3, 'default1', 2), (4, 'default1', 1), (5, 'default2', 1), (6, '2019-01-01', 2), (7, 'default1', 1), (8, '2019-01-01', 2), (9, '2019-03-31', 1), (10, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, NULL, '2019-04-01', 2, 1), (0, 0, NULL, '2019-01-02', 1, 2), (10, 1, 1, NULL, 1, 2), (9, 2, 1, '2019-03-31', NULL, 2), (1, 2, 2, '2023-01-02', NULL, 2), (3, 2, 1, '2019-03-30', 1, NULL), (8, 1, NULL, '2019-01-01', 2, 2), (6, 2, 2, '2019-03-30', 2, 2), (7, 1, 2, '2023-01-01', 1, NULL), (5, 1, 2, '2019-01-02', 2, 2), (9, 2, NULL, '2023-01-01', 2, 1), (4, 2, 1, '2023-01-02', NULL, 1), (2, NULL, 2, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, 'default1')
(10, None)
(3, 'default1')
(8, '2019-01-01')
(6, '2019-01-01')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING COUNT(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN PRODUCT_ID END) = COUNT(1));

/*
Prediction Result:
(0, 'default1')
(3, 'default1')
(6, '2019-01-01')
(8, '2019-01-01')
*/