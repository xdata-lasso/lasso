-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, NULL, 1), (2, 'default1', 1), (3, 'default1', NULL), (4, NULL, 1), (5, NULL, NULL), (6, '2019-01-01', 1), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, NULL, 0, '2023-01-01', NULL, NULL), (5, 1, 0, '2023-01-02', NULL, NULL), (7, 1, NULL, '2019-03-31', 1, NULL), (6, NULL, NULL, '2018-12-31', 1, NULL), (4, NULL, 1, '2019-03-30', NULL, 1), (2, NULL, 0, '2019-01-01', NULL, 1), (6, NULL, 0, '2023-01-01', 1, 1), (5, 0, NULL, '2019-01-01', 1, NULL), (5, NULL, 1, '2019-03-30', NULL, NULL), (6, 1, 0, '2023-01-01', 1, 1), (NULL, 0, 1, NULL, 1, 1), (7, 0, NULL, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, None)
(2, 'default1')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' ORDER BY P.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(2, 'default1')
(4, None)
*/