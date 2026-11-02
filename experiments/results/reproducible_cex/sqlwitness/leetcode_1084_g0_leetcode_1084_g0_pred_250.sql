-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 3), (2, 'default2', NULL), (3, '2019-01-01', 1), (1, '2019-01-01', 1), (4, '2019-01-01', 3), (5, NULL, 3), (6, '2019-03-31', 3), (7, NULL, 1), (8, NULL, 3), (9, '2019-03-31', 1), (10, '2019-01-01', 1), (11, NULL, NULL), (12, '2019-01-01', 3), (13, '2019-01-01', 1), (14, '2019-01-01', 1), (15, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, 1, 2, '2019-03-31', 1, NULL), (15, 1, 2, '2019-01-02', 1, 1), (11, NULL, 2, '2023-01-01', 3, 1), (12, 3, 3, NULL, 2, 2), (4, 0, NULL, '2018-12-31', NULL, 2), (4, 2, 0, '2018-12-31', NULL, 2), (0, 0, 1, NULL, NULL, 2), (7, 0, 3, '2019-01-01', 1, 2), (3, 0, 2, '2019-03-31', NULL, NULL), (0, 0, 2, '2023-01-02', NULL, NULL), (13, 2, 0, '2019-01-02', 2, NULL), (NULL, 3, 0, '2019-04-01', 1, 1), (1, NULL, NULL, '2018-12-31', NULL, 1), (14, 1, 0, '2023-01-02', NULL, NULL), (9, 0, 0, '2019-03-31', NULL, NULL), (10, 0, 1, '2019-04-01', 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-01-01')
(7, None)
(9, '2019-03-31')
(12, '2019-01-01')
(13, '2019-01-01')
(15, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' GROUP BY 1, 2 ORDER BY 1, 2, S.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/