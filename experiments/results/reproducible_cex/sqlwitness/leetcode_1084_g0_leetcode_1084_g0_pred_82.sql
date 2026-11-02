-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, '2019-01-01', 1), (2, 'default2', 1), (3, '2019-03-31', NULL), (4, 'default2', NULL), (5, NULL, NULL), (6, '2019-01-01', 1), (7, 'default2', NULL), (8, 'default2', NULL), (9, '2019-03-31', 1), (10, 'default1', 1), (11, 'default1', NULL), (12, 'default2', NULL), (13, NULL, 1), (14, NULL, 1), (15, 'default2', 1), (16, NULL, 1), (17, 'default2', 1), (18, 'default2', NULL), (19, 'default1', 1), (20, '2019-03-31', 1), (21, '2019-03-31', NULL), (22, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, NULL, '2019-01-02', 1, 1), (13, 1, 1, '2019-03-31', 1, 1), (6, 1, 0, '2019-03-30', 1, NULL), (NULL, 0, NULL, '2019-01-02', NULL, 1), (16, 0, NULL, '2019-01-02', NULL, NULL), (8, 0, NULL, '2019-01-02', NULL, NULL), (6, NULL, NULL, '2023-01-02', 1, NULL), (NULL, 0, 1, '2018-12-31', 1, 1), (16, NULL, 1, '2019-04-01', NULL, 1), (10, NULL, 1, '2019-03-31', NULL, 1), (22, 0, NULL, '2019-03-30', NULL, 1), (8, 0, NULL, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(5, None)
(10, 'default1')
(13, None)
(22, '2019-01-01')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/