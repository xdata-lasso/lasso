-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, 'default2', NULL), (2, '2019-01-01', 1), (3, NULL, 1), (4, 'default2', NULL), (5, '2019-03-31', NULL), (6, 'default1', NULL), (7, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, '2023-01-02', 1, 1), (5, 1, NULL, '2023-01-02', 1, NULL), (0, 0, 0, '2019-04-01', NULL, NULL), (3, 1, 1, NULL, 1, 1), (5, NULL, 1, '2019-03-30', NULL, 1), (2, 0, NULL, '2019-01-02', 1, 1), (2, 0, 1, '2019-03-31', 1, 1), (5, 1, 0, '2018-12-31', 1, 1), (2, NULL, 1, '2023-01-01', 1, NULL), (3, NULL, 1, '2023-01-02', 1, 1), (1, NULL, NULL, NULL, NULL, 1), (2, NULL, NULL, '2023-01-01', 1, 1), (7, 1, 1, '2019-03-30', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(7, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE NOT PRODUCT.PRODUCT_ID IN (SELECT DISTINCT SALES.PRODUCT_ID FROM SALES WHERE SALES.SALE_DATE > '2019-03-31' OR SALES.SALE_DATE < '2019-01-01');

/*
Prediction Result:
(1, '2019-01-01')
(7, '2019-01-01')
*/