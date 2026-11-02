-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, 'default2', 1), (2, NULL, NULL), (3, 'default1', 1), (4, 'default2', NULL), (5, NULL, NULL), (6, 'default2', 1), (7, '2019-01-01', NULL), (8, 'default2', NULL), (9, 'default2', NULL), (10, NULL, 1), (11, '2019-01-01', NULL), (12, NULL, NULL), (13, '2019-03-31', 1), (14, '2019-01-01', NULL), (15, '2019-03-31', NULL), (16, 'default2', 1), (17, 'default2', 1), (18, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 1, 1, '2018-12-31', NULL, NULL), (15, 1, 0, NULL, 1, NULL), (2, 1, NULL, '2023-01-02', 1, 1), (12, 1, 0, '2019-03-30', 1, 1), (0, NULL, 0, '2023-01-01', 1, 1), (15, NULL, 1, '2019-01-01', 1, NULL), (16, NULL, NULL, '2019-03-30', 1, 1), (10, NULL, NULL, '2023-01-01', 1, NULL), (1, NULL, 1, NULL, 1, NULL), (16, 0, 1, '2023-01-01', NULL, NULL), (NULL, 0, 0, '2019-03-30', NULL, 1), (0, 0, 1, '2019-03-30', 1, NULL), (4, 0, NULL, '2019-03-31', 1, 1), (18, NULL, 1, NULL, NULL, 1), (5, 1, 1, '2019-03-31', 1, NULL), (10, 0, 1, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(15, '2019-03-31')
(12, None)
(1, '2019-03-31')
(4, 'default2')
(18, 'default2')
(5, None)
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(12, None)
(15, '2019-03-31')
(4, 'default2')
(5, None)
*/