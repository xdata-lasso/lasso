-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'iPhone', NULL), (2, 'iPhone', NULL), (3, 'default2', NULL), (4, 'S8', NULL), (5, 'default1', NULL), (6, 'S8', NULL), (7, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 1, '2023-01-01', 1, 1), (NULL, 0, NULL, NULL, 1, 1), (6, 1, 1, '2023-01-01', 1, NULL), (7, 0, 0, '2023-01-01', 1, NULL), (2, 1, NULL, '2023-01-02', 1, 1), (7, NULL, 0, '2023-01-02', NULL, 1), (6, NULL, NULL, NULL, NULL, 1), (4, 0, NULL, '2023-01-02', 1, NULL), (1, 0, 0, '2023-01-02', 1, NULL), (4, NULL, 1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT X.BUYER_ID FROM (SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AS X LEFT JOIN (SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') AS Y ON X.BUYER_ID = Y.BUYER_ID WHERE Y.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/