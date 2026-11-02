-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', 1), (0, 'default2', NULL), (2, '2019-03-31', 1), (3, '2019-01-01', NULL), (4, 'default1', NULL), (5, 'default2', NULL), (6, 'default1', 1), (7, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, NULL, '2019-03-30', 1, NULL), (NULL, NULL, 0, '2019-01-01', NULL, 1), (0, NULL, 1, '2019-01-02', 1, 1), (NULL, NULL, 1, '2019-01-01', NULL, NULL), (NULL, NULL, 0, '2019-03-30', 1, NULL), (1, 0, NULL, '2019-04-01', 1, NULL), (7, 1, 0, '2018-12-31', 1, 1), (6, NULL, 0, NULL, 1, NULL), (6, 1, NULL, '2019-01-01', 1, NULL), (7, NULL, NULL, '2019-03-31', 1, 1), (3, 1, 1, '2019-03-31', NULL, NULL), (7, NULL, NULL, '2023-01-01', 1, 1), (NULL, NULL, NULL, '2019-04-01', 1, 1), (0, 1, 0, '2019-03-31', 1, NULL), (2, NULL, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE NOT PRODUCT.PRODUCT_ID IN (SELECT PRODUCT.PRODUCT_ID FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALES.SALE_DATE > '2019-03-31' OR SALES.SALE_DATE < '2019-01-01');

/*
Prediction Result:
(5, 'default2')
(0, 'default2')
(6, 'default1')
(3, '2019-01-01')
*/