-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'default1', NULL), (2, NULL, NULL), (3, 'default1', 1), (4, '2019-03-31', 1), (5, '2019-03-31', 1), (6, 'default1', NULL), (7, '2019-03-31', NULL), (8, '2019-03-31', NULL), (9, 'default2', NULL), (10, NULL, 1), (11, '2019-01-01', 1), (12, 'default2', 1), (13, '2019-01-01', 1), (14, '2019-01-01', NULL), (15, 'default2', NULL), (16, NULL, 1), (17, 'default1', NULL), (18, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, 0, '2023-01-02', NULL, 1), (8, 0, NULL, NULL, NULL, NULL), (6, NULL, 0, '2019-03-30', NULL, 1), (15, 1, 1, '2018-12-31', 1, NULL), (3, 1, 0, '2019-03-30', 1, 1), (9, 0, 0, '2019-04-01', 1, NULL), (12, NULL, 0, '2019-03-30', 1, 1), (5, NULL, 1, '2018-12-31', NULL, 1), (1, NULL, 0, '2019-04-01', 1, NULL), (10, 0, NULL, '2019-01-02', NULL, 1), (3, 1, 1, '2019-03-30', NULL, 1), (7, 0, 0, '2018-12-31', NULL, NULL), (12, NULL, 0, '2019-03-30', NULL, NULL), (12, NULL, 0, '2019-04-01', NULL, NULL), (4, 1, NULL, '2019-04-01', 1, NULL), (9, NULL, 1, '2019-01-01', NULL, NULL), (7, 1, NULL, '2023-01-02', 1, 1), (18, 0, NULL, NULL, NULL, 1), (8, 0, 1, '2019-03-31', NULL, NULL), (3, NULL, 0, '2018-12-31', 1, 1), (14, 0, NULL, '2019-04-01', 1, NULL), (12, 1, 1, NULL, 1, NULL), (11, 0, 1, '2023-01-02', NULL, 1), (11, NULL, 0, '2019-03-30', NULL, 1), (5, 0, NULL, '2019-03-30', 1, NULL), (15, 1, NULL, '2023-01-02', NULL, NULL), (14, 0, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(8, '2019-03-31')
(6, 'default1')
(10, None)
(18, 'default2')
*/

-- Prediction Query
SELECT DISTINCT B.PRODUCT_ID, B.PRODUCT_NAME FROM (SELECT * FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE NOT B.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(6, 'default1')
(10, None)
(8, '2019-03-31')
*/