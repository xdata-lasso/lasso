-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, NULL, NULL), (2, 'default1', NULL), (3, 'default1', NULL), (4, '2019-03-31', 1), (5, NULL, NULL), (6, 'default2', NULL), (7, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 0, 1, '2018-12-31', NULL, NULL), (NULL, NULL, 0, '2018-12-31', NULL, 1), (5, 1, NULL, '2023-01-01', 1, NULL), (1, 1, 0, '2019-01-02', NULL, 1), (1, NULL, 0, '2023-01-01', NULL, NULL), (1, NULL, NULL, '2018-12-31', 1, NULL), (5, NULL, 1, '2018-12-31', NULL, NULL), (6, 1, NULL, '2018-12-31', NULL, NULL), (NULL, 0, NULL, '2019-04-01', NULL, 1), (7, 1, NULL, '2019-03-30', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT NATURAL JOIN SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(7, None)
*/