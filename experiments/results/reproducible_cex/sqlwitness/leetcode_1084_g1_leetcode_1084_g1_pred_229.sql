-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, '2019-01-01', NULL), (2, 'default1', NULL), (3, '2019-03-31', NULL), (4, NULL, NULL), (5, '2019-03-31', NULL), (6, 'default2', NULL), (7, '2019-03-31', NULL), (8, 'default1', NULL), (9, 'default2', 1), (10, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 1, '2023-01-01', NULL, NULL), (5, NULL, 0, '2019-03-30', 1, 1), (NULL, 1, NULL, '2019-04-01', 1, NULL), (4, 0, 0, '2019-03-31', 1, 1), (3, 1, 0, '2019-01-02', 1, 1), (NULL, 1, 0, '2019-01-02', 1, 1), (3, 0, NULL, '2019-03-31', NULL, 1), (2, 0, NULL, '2019-03-31', NULL, NULL), (1, 1, 1, '2023-01-01', NULL, 1), (NULL, NULL, NULL, '2018-12-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31');

/*
Prediction Result:
(3, '2019-03-31')
(4, None)
(5, '2019-03-31')
*/