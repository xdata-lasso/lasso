-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'S8', NULL), (2, 'default2', NULL), (3, 'default1', NULL), (4, 'iPhone', NULL), (5, 'S8', NULL), (6, 'default2', 1), (7, 'default1', NULL), (8, 'default1', NULL), (9, 'default2', NULL), (10, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, NULL, 1, NULL, 1, NULL), (7, 0, 0, NULL, 1, NULL), (1, NULL, 0, NULL, 1, NULL), (9, 1, 0, '2023-01-01', 1, NULL), (5, 0, 0, NULL, 1, 1), (NULL, NULL, NULL, '2023-01-02', NULL, NULL), (1, 0, NULL, '2023-01-01', NULL, 1), (0, NULL, 1, '2023-01-01', NULL, 1), (5, NULL, NULL, NULL, NULL, NULL), (2, 0, 0, '2023-01-02', 1, NULL), (5, 1, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(1,)
(None,)
*/

-- Prediction Query
WITH A AS (SELECT S.PRODUCT_ID, S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM A WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM A WHERE PRODUCT_NAME = 'iPhone') AND BUYER_ID IN (SELECT BUYER_ID FROM A WHERE PRODUCT_NAME = 'S8');

/*
Prediction Result:
(1,)
(0,)
*/