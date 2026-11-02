-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 2), (0, 'default2', 3), (2, NULL, 1), (3, '2019-01-01', 1), (4, NULL, 3), (5, '2019-01-01', NULL), (6, NULL, NULL), (7, 'default1', 3), (8, NULL, 1), (9, NULL, NULL), (10, '2019-01-01', NULL), (11, '2019-01-01', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, NULL, '2018-12-31', 1, NULL), (8, 0, NULL, '2019-01-01', NULL, 1), (0, 3, 3, '2019-03-31', 1, 3), (0, 1, 0, '2019-04-01', 2, 3), (4, NULL, 3, '2018-12-31', 3, 1), (0, 1, 2, '2019-03-31', NULL, 2), (9, 3, NULL, '2019-03-30', 1, 1), (9, 0, 1, NULL, 1, 2), (6, 2, 3, '2019-04-01', 3, 3), (3, 3, 2, '2019-03-31', 3, 1), (NULL, 1, 0, NULL, NULL, 2), (8, 2, 3, '2019-01-02', 3, 3), (8, 3, 2, '2019-01-01', 3, NULL), (7, 2, 0, NULL, 3, 3), (NULL, 0, 0, '2019-01-01', 3, 2), (5, NULL, 2, '2019-03-30', 2, 2), (11, 2, NULL, '2023-01-01', 3, 2), (5, 2, NULL, '2019-01-01', 3, 1), (1, 1, 3, NULL, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-01-01')
(5, '2019-01-01')
(8, None)
(9, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/