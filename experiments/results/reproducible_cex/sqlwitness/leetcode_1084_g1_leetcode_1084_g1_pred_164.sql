-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'default2', NULL), (2, 'default1', NULL), (3, NULL, 1), (4, '2019-01-01', NULL), (5, '2019-01-01', 1), (6, 'default2', 1), (7, 'default2', 1), (8, 'default2', 1), (9, NULL, NULL), (10, NULL, NULL), (11, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 1, '2019-03-31', 1, NULL), (7, NULL, 0, '2019-01-01', 1, NULL), (2, NULL, NULL, NULL, 1, 1), (3, NULL, 1, '2023-01-02', NULL, NULL), (4, NULL, NULL, '2019-01-01', NULL, 1), (1, 0, 0, '2019-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, '2019-01-01')
(7, 'default2')
(2, 'default1')
(4, '2019-01-01')
(1, 'default2')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') ORDER BY P.PRODUCT_ID, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(1, 'default2')
(4, '2019-01-01')
(5, '2019-01-01')
(7, 'default2')
*/