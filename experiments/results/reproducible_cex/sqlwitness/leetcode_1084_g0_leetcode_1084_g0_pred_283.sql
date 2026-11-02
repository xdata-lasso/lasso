-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (2, NULL, 2), (1, NULL, 2), (3, 'default2', 1), (4, 'default2', 1), (5, '2019-01-01', 2), (6, 'default1', 2), (7, '2019-01-01', NULL), (8, 'default2', 2), (9, 'default1', 2), (10, NULL, 1), (11, '2019-03-31', 2), (12, '2019-01-01', 2), (13, 'default2', 1), (14, '2019-03-31', 1), (15, '2019-01-01', NULL), (16, '2019-01-01', 2), (17, 'default1', 1), (18, '2019-01-01', NULL), (19, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 1, 0, '2018-12-31', 2, 2), (16, 2, 0, '2019-01-02', 2, NULL), (19, NULL, 0, '2019-01-01', 1, NULL), (5, NULL, 1, '2019-01-01', 2, NULL), (8, 0, NULL, NULL, 2, 1), (9, 2, 0, '2018-12-31', 1, NULL), (17, 2, 0, '2019-04-01', NULL, 1), (4, NULL, 0, '2019-04-01', 1, 2), (14, 2, 2, '2023-01-02', 1, NULL), (NULL, NULL, 1, '2019-04-01', NULL, 1), (0, 0, NULL, NULL, 1, 1), (12, 2, NULL, '2019-01-01', 2, NULL), (17, 1, 1, '2023-01-01', 1, NULL), (3, 0, 1, '2018-12-31', 2, NULL), (16, 2, 1, '2019-04-01', NULL, NULL), (1, NULL, NULL, '2019-03-31', 2, 2), (11, 1, 1, NULL, NULL, 2), (13, 2, 0, '2018-12-31', NULL, 1), (8, 0, NULL, '2023-01-01', 1, 2), (18, NULL, 2, '2019-01-02', NULL, NULL), (16, 2, 1, '2019-01-02', 2, NULL), (NULL, NULL, 0, '2018-12-31', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, None)
(5, '2019-01-01')
(12, '2019-01-01')
(18, '2019-01-01')
(19, 'default2')
*/

-- Prediction Query
WITH TEMP AS (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT DISTINCT P.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT * FROM TEMP) ORDER BY 1, P.PRODUCT_ID NULLS LAST, PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/