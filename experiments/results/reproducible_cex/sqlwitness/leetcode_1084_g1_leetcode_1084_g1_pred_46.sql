-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, 'default2', NULL), (2, NULL, NULL), (3, 'default1', 1), (4, '2019-03-31', 1), (5, '2019-01-01', 1), (6, 'default1', NULL), (7, 'default1', 1), (8, 'default2', NULL), (9, '2019-01-01', 1), (10, '2019-01-01', NULL), (11, '2019-03-31', 1), (12, '2019-03-31', 1), (13, 'default2', 1), (14, 'default2', NULL), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (15, 1, 1, '2023-01-02', 1, 1), (8, 1, 0, '2019-04-01', 1, NULL), (10, NULL, 0, '2018-12-31', NULL, 1), (NULL, 0, 0, '2019-01-02', 1, 1), (6, 1, 1, '2019-04-01', NULL, NULL), (10, NULL, 1, '2019-03-31', 1, NULL), (13, 0, NULL, NULL, NULL, NULL), (0, 1, NULL, '2019-03-30', NULL, NULL), (11, 0, 1, '2019-03-31', NULL, NULL), (5, NULL, 0, '2019-03-31', NULL, NULL), (11, NULL, NULL, '2019-01-02', 1, 1), (9, NULL, 0, '2019-03-30', 1, NULL), (14, NULL, 1, '2023-01-02', 1, 1), (11, 0, 0, '2019-01-02', NULL, 1), (0, 0, NULL, NULL, 1, 1), (3, 0, 0, '2019-04-01', 1, 1), (5, NULL, 0, NULL, NULL, NULL), (4, 0, 0, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(13, 'default2')
(0, 'default2')
(11, '2019-03-31')
(5, '2019-01-01')
(9, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT SALES.PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY PRODUCT.PRODUCT_ID;

/*
Prediction Result:
(0, 'default2')
(5, '2019-01-01')
(9, '2019-01-01')
(11, '2019-03-31')
*/