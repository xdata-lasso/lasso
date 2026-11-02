-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (1, '2019-01-01', 1), (2, NULL, NULL), (3, '2019-03-31', 1), (4, '2019-03-31', NULL), (5, '2019-01-01', NULL), (6, '2019-03-31', NULL), (7, NULL, NULL), (8, '2019-01-01', 1), (9, 'default2', 1), (10, '2019-03-31', NULL), (11, '2019-03-31', NULL), (12, 'default2', NULL), (13, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 1, '2019-04-01', 1, NULL), (9, 1, 0, '2018-12-31', NULL, 1), (13, 0, 0, '2019-04-01', 1, 1), (3, 0, NULL, '2019-03-30', 1, NULL), (5, 0, 0, '2018-12-31', NULL, NULL), (5, 1, NULL, '2023-01-01', 1, 1), (2, 1, NULL, NULL, NULL, 1), (8, NULL, 0, '2019-03-30', NULL, 1), (0, 0, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, '2019-03-31')
(2, None)
(8, '2019-01-01')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT SA.PRODUCT_ID FROM SALES AS SA WHERE NOT SA.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'));

/*
Prediction Result:
(3, '2019-03-31')
(8, '2019-01-01')
*/