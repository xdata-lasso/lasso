-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'default1', 1), (2, '2019-01-01', NULL), (3, 'default2', 1), (4, 'default2', 1), (5, NULL, 1), (6, '2019-01-01', NULL), (7, '2019-01-01', 1), (8, 'default2', 1), (9, 'default2', 1), (10, '2019-01-01', 1), (11, '2019-03-31', NULL), (12, 'default1', NULL), (13, NULL, NULL), (14, NULL, NULL), (15, '2019-03-31', 1), (16, 'default2', NULL), (17, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 0, NULL, NULL, NULL), (13, NULL, 1, '2019-03-31', 1, 1), (NULL, 0, NULL, NULL, 1, 1), (1, 1, 1, '2019-01-01', 1, NULL), (NULL, 1, 1, '2019-03-30', NULL, NULL), (7, 0, NULL, NULL, 1, 1), (9, 0, 1, '2023-01-02', NULL, NULL), (5, NULL, 1, '2019-03-31', 1, NULL), (6, NULL, NULL, '2019-04-01', NULL, NULL), (3, 1, 0, '2019-03-31', NULL, NULL), (10, 0, NULL, '2019-03-30', 1, 1), (17, NULL, NULL, '2023-01-02', 1, NULL), (4, NULL, 0, '2019-01-01', NULL, 1), (9, NULL, 1, '2023-01-01', 1, 1), (10, NULL, NULL, '2019-01-02', 1, NULL), (16, 0, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, 'default1')
(13, None)
(1, 'default1')
(7, '2019-01-01')
(5, None)
(3, 'default2')
(10, '2019-01-01')
(4, 'default2')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME;

/*
Prediction Result:
(1, 'default1')
(3, 'default2')
(4, 'default2')
(5, None)
(10, '2019-01-01')
(13, None)
*/