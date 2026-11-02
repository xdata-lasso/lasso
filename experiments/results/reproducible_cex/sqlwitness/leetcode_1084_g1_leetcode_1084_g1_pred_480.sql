-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, NULL, NULL), (2, '2019-03-31', 1), (3, '2019-03-31', 1), (4, 'default2', NULL), (5, '2019-03-31', 1), (6, 'default2', 1), (7, NULL, NULL), (8, 'default1', 1), (9, '2019-01-01', 1), (10, 'default2', 1), (11, '2019-01-01', 1), (12, '2019-01-01', 1), (13, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, 1, '2023-01-02', 1, NULL), (13, 1, 1, '2023-01-02', NULL, NULL), (9, NULL, 1, '2023-01-01', NULL, NULL), (7, 0, 0, '2019-03-31', 1, 1), (3, 0, 1, '2019-03-31', NULL, NULL), (1, 1, 0, NULL, NULL, NULL), (6, 0, 1, '2018-12-31', NULL, NULL), (NULL, 1, NULL, '2019-04-01', 1, 1), (11, 1, NULL, '2019-03-30', NULL, 1), (11, NULL, 0, '2019-04-01', NULL, 1), (NULL, NULL, NULL, '2019-01-02', NULL, 1), (7, NULL, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31');

/*
Prediction Result:
(3, '2019-03-31')
*/