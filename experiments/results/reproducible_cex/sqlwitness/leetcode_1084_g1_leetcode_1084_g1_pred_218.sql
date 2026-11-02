-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (1, 'default2', 1), (0, 'default1', NULL), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default2', NULL), (6, 'default1', 2), (7, NULL, NULL), (8, 'default2', 1), (9, '2019-01-01', 2), (10, '2019-03-31', 2), (11, '2019-03-31', 2), (12, '2019-01-01', NULL), (13, '2019-03-31', 2), (14, '2019-03-31', 1), (15, 'default2', NULL), (16, 'default1', 1), (17, '2019-03-31', 1), (18, '2019-03-31', 1), (19, NULL, 2), (20, NULL, 2), (21, 'default1', 2), (22, 'default1', 1), (23, 'default1', NULL), (24, 'default1', 1), (25, NULL, NULL), (26, '2019-01-01', NULL), (27, NULL, 2), (28, '2019-01-01', NULL), (29, NULL, 1), (30, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (25, NULL, 1, '2019-03-31', 1, NULL), (9, 1, 0, '2019-03-31', 1, NULL), (4, 2, 0, '2023-01-02', 2, 1), (3, NULL, 1, '2023-01-01', 2, NULL), (24, NULL, 0, '2023-01-02', 1, 2), (15, 0, NULL, '2019-04-01', 1, 2), (27, 0, 1, '2019-03-31', 1, 1), (29, 0, NULL, NULL, 2, 2), (20, 0, 2, '2023-01-01', 1, 1), (25, 2, NULL, '2019-03-31', 2, 2), (27, 0, 0, '2023-01-02', NULL, 2), (24, 0, 2, '2019-04-01', 1, 2), (17, 0, NULL, '2019-01-02', NULL, NULL), (24, 2, 2, '2019-03-31', NULL, 1), (NULL, NULL, NULL, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(25, None)
(9, '2019-01-01')
(29, None)
(17, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1;

/*
Prediction Result:
(9, '2019-01-01')
(17, '2019-03-31')
(25, None)
*/