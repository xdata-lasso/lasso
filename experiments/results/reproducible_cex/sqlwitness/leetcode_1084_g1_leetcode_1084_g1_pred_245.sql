-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, '2019-01-01', 1), (2, '2019-01-01', NULL), (3, '2019-03-31', 1), (4, 'default1', 1), (5, '2019-01-01', NULL), (6, NULL, 1), (7, NULL, 1), (8, 'default2', 1), (9, 'default1', 1), (10, '2019-03-31', 1), (11, '2019-01-01', 1), (12, '2019-03-31', NULL), (13, '2019-01-01', 1), (14, NULL, NULL), (15, 'default2', 1), (16, NULL, 1), (17, NULL, 1), (18, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, 1, '2019-03-30', NULL, NULL), (6, 0, 1, '2019-03-31', NULL, NULL), (8, 0, 1, '2023-01-02', 1, 1), (7, 0, 1, '2019-03-31', 1, 1), (7, NULL, 1, '2019-03-31', NULL, NULL), (5, NULL, NULL, '2019-04-01', NULL, NULL), (1, 1, 0, '2019-01-02', 1, 1), (14, 0, NULL, NULL, NULL, NULL), (11, 0, NULL, '2023-01-02', 1, NULL), (15, NULL, 0, '2019-01-02', 1, 1), (10, 1, NULL, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(7, None)
(6, None)
(1, 'default1')
(14, None)
(15, 'default2')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31'));

/*
Prediction Result:
(1, 'default1')
(6, None)
(7, None)
(15, 'default2')
*/