-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, '2019-03-31', 1), (2, 'default1', 1), (3, NULL, NULL), (4, NULL, 1), (5, NULL, NULL), (6, 'default2', 1), (7, 'default1', 1), (8, NULL, 1), (9, NULL, NULL), (10, NULL, 1), (11, '2019-03-31', NULL), (12, '2019-03-31', NULL), (13, 'default1', 1), (14, NULL, NULL), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 0, NULL, NULL, 1), (5, 1, NULL, '2023-01-02', 1, NULL), (9, NULL, 0, '2018-12-31', 1, 1), (11, NULL, 1, NULL, NULL, NULL), (15, 0, NULL, '2019-01-02', NULL, 1), (13, NULL, 1, '2018-12-31', NULL, NULL), (4, 0, 1, NULL, NULL, NULL), (4, NULL, 0, '2019-01-01', 1, NULL), (15, 1, NULL, '2019-03-31', 1, 1), (10, 0, 1, NULL, NULL, NULL), (7, 0, 1, '2019-04-01', NULL, 1), (13, 0, NULL, '2023-01-01', NULL, NULL), (6, 1, 0, '2019-01-02', NULL, NULL), (15, 1, 1, '2019-03-31', 1, NULL), (5, NULL, 1, '2023-01-02', 1, NULL), (5, 0, NULL, '2019-04-01', NULL, NULL), (10, 1, NULL, '2019-01-01', 1, 1), (2, 1, 1, '2019-01-02', NULL, 1), (12, NULL, NULL, '2019-04-01', 1, 1), (11, 0, 1, '2019-04-01', 1, 1), (6, NULL, 0, '2019-03-31', 1, 1), (NULL, 0, NULL, '2019-03-31', 1, 1), (15, 0, 1, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, None)
(15, 'default1')
(4, None)
(10, None)
(6, 'default2')
(2, 'default1')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT S.PRODUCT_ID FROM SALES AS S WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(15, 'default1')
(4, None)
(6, 'default2')
(10, None)
(2, 'default1')
*/