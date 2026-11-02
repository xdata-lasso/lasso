-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, '2019-03-31', NULL), (2, NULL, NULL), (3, '2019-01-01', 1), (4, '2019-03-31', 1), (5, '2019-01-01', NULL), (6, 'default1', 1), (7, NULL, NULL), (8, NULL, 1), (9, NULL, NULL), (10, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, NULL, '2023-01-02', 1, NULL), (NULL, 0, 0, '2023-01-01', NULL, 1), (5, NULL, NULL, '2018-12-31', NULL, 1), (3, NULL, 0, '2023-01-01', NULL, NULL), (NULL, 1, NULL, NULL, 1, 1), (5, NULL, 1, '2023-01-01', NULL, 1), (10, 1, NULL, '2019-01-02', 1, 1), (7, 1, 0, '2019-01-02', NULL, 1), (NULL, 0, NULL, '2018-12-31', 1, NULL), (NULL, NULL, NULL, '2019-03-31', 1, 1), (7, NULL, 1, '2019-03-31', NULL, 1), (7, 0, 0, '2019-01-02', 1, 1), (3, 1, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(7, None)
(10, 'default1')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM SALES NATURAL JOIN PRODUCT WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/