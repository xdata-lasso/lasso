-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, '2019-03-31', NULL), (2, 'default1', NULL), (3, '2019-03-31', 1), (4, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, '2018-12-31', 1, 1), (2, NULL, 0, '2023-01-01', NULL, 1), (4, NULL, NULL, '2023-01-02', NULL, NULL), (NULL, NULL, NULL, '2023-01-01', NULL, NULL), (2, 0, NULL, '2019-01-02', 1, NULL), (0, 0, NULL, '2019-03-30', 1, NULL), (NULL, NULL, 1, '2019-01-02', NULL, NULL), (0, 1, 0, '2019-03-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM (SELECT PRODUCT_ID, MIN(SALE_DATE) AS MIN_DATE, MAX(SALE_DATE) AS MAX_DATE FROM SALES GROUP BY PRODUCT_ID) AS NS JOIN PRODUCT AS P ON NS.PRODUCT_ID = P.PRODUCT_ID WHERE NS.MIN_DATE >= DATE('2019-01-01') AND NS.MAX_DATE <= DATE('2019-03-31');

/*
Prediction Result:
(0, None)
*/