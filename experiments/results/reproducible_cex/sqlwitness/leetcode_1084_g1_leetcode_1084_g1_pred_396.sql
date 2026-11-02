-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, NULL), (0, 'default1', 1), (1, '2019-03-31', 1), (3, 'default2', 2), (4, 'default1', 1), (5, NULL, 1), (6, 'default2', 2), (7, NULL, NULL), (8, 'default2', 1), (9, 'default1', 2), (10, 'default1', 2), (11, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, NULL, '2023-01-01', 2, NULL), (11, 2, 0, '2019-01-01', 2, 2), (10, 1, 2, '2019-01-01', 2, 1), (5, 2, 0, NULL, 2, 2), (2, 2, 2, '2019-03-31', 2, 2), (6, 2, 1, '2018-12-31', NULL, 1), (11, NULL, NULL, '2019-03-31', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(11, '2019-03-31')
(10, 'default1')
(5, None)
(2, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT NATURAL JOIN SALES GROUP BY 1 HAVING MIN(SALE_DATE) >= DATE('2019-01-01') AND MAX(SALE_DATE) <= DATE('2019-03-31');

/*
Prediction Result:
(2, None)
(10, 'default1')
(11, '2019-03-31')
*/