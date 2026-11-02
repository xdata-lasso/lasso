-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 1), (0, '2019-03-31', 1), (-1, '2019-01-01', NULL), (2, '2019-03-31', 2), (3, 'default2', NULL), (4, 'default2', 2), (5, 'default1', NULL), (6, 'default1', 2), (7, 'default1', 1), (8, 'default1', NULL), (9, NULL, 1), (10, NULL, 2), (11, '2019-03-31', 2), (12, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, -1, 0, '2019-04-01', 2, NULL), (3, 0, 1, '2019-03-31', NULL, 1), (0, -1, 2, '2019-01-01', 1, 2), (-1, 1, 1, '2019-04-01', NULL, 1), (11, -1, 0, '2019-01-02', 1, NULL), (12, 0, 1, '2023-01-02', 1, NULL), (6, NULL, -1, '2019-04-01', 1, NULL), (12, 1, -1, '2023-01-02', NULL, 2), (9, 0, NULL, NULL, 2, 1), (6, 2, 0, '2019-01-01', NULL, NULL), (-1, NULL, -1, '2019-03-31', 1, NULL), (6, 2, -1, '2018-12-31', 2, 1), (5, 2, 0, '2018-12-31', 1, 2), (12, -1, 2, NULL, 2, 2), (11, -1, NULL, '2018-12-31', 2, 2), (0, 0, NULL, '2019-03-30', 1, 1), (1, 0, 2, '2019-03-30', NULL, 1), (11, -1, 1, '2019-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, '2019-03-31')
(1, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID, P.PRODUCT_NAME HAVING MAX(IIF(NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 0;

/*
Prediction Result:
(0, '2019-03-31')
(1, '2019-03-31')
(9, None)
*/