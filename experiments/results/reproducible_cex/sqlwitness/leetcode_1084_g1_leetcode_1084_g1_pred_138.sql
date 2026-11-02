-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, '2019-03-31', 1), (2, '2019-03-31', 1), (3, '2019-03-31', 1), (4, NULL, 1), (5, 'default1', NULL), (6, 'default1', 1), (7, '2019-03-31', NULL), (8, NULL, NULL), (9, NULL, 1), (10, 'default2', 1), (11, 'default1', 1), (12, NULL, NULL), (13, 'default2', NULL), (14, '2019-01-01', 1), (15, 'default1', NULL), (16, '2019-03-31', 1), (17, NULL, NULL), (18, '2019-03-31', NULL), (19, '2019-01-01', NULL), (20, '2019-03-31', NULL), (21, 'default1', NULL), (22, NULL, NULL), (23, 'default2', 1), (24, '2019-01-01', NULL), (25, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (19, 0, 1, '2019-01-02', 1, 1), (23, NULL, 1, '2023-01-02', NULL, NULL), (21, 1, 0, NULL, NULL, NULL), (10, NULL, 0, '2018-12-31', 1, NULL), (24, 1, 0, '2019-01-02', 1, NULL), (20, NULL, NULL, '2019-03-30', NULL, NULL), (18, 1, NULL, NULL, NULL, NULL), (17, 1, NULL, '2019-01-02', NULL, 1), (2, 0, NULL, NULL, 1, NULL), (4, 0, 1, '2023-01-01', 1, NULL), (19, 0, 0, '2023-01-01', NULL, 1), (11, NULL, 1, '2019-01-02', NULL, NULL), (15, 0, 1, '2019-03-31', NULL, NULL), (9, NULL, 0, '2019-04-01', 1, NULL), (21, NULL, NULL, '2018-12-31', 1, 1), (15, 0, 0, NULL, NULL, 1), (3, NULL, 0, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(24, '2019-01-01')
(20, '2019-03-31')
(18, '2019-03-31')
(17, None)
(2, '2019-03-31')
(11, 'default1')
(15, 'default1')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE (A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT A.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(24, '2019-01-01')
(20, '2019-03-31')
(17, None)
(11, 'default1')
(15, 'default1')
*/