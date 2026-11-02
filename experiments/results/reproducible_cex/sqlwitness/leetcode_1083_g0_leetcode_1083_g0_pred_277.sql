-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, 'iPhone', 1), (2, 'default2', 1), (3, 'default2', 1), (4, 'default1', 1), (5, NULL, 1), (6, 'S8', NULL), (7, 'default1', 1), (8, 'default1', 1), (9, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, 0, NULL, 1, 1), (7, 0, 0, NULL, 1, 1), (6, NULL, NULL, '2023-01-01', NULL, NULL), (9, 1, 1, '2023-01-02', NULL, 1), (2, 0, NULL, '2023-01-02', 1, 1), (NULL, 0, 0, '2023-01-01', NULL, NULL), (1, 0, NULL, '2023-01-01', NULL, NULL), (8, 0, 1, '2023-01-02', NULL, NULL), (4, 1, 1, '2023-01-02', NULL, NULL), (9, 1, NULL, '2023-01-01', NULL, NULL), (9, 1, 1, '2023-01-02', 1, 1), (2, 1, 1, '2023-01-02', 1, NULL), (5, 1, 0, '2023-01-02', 1, NULL), (NULL, 1, 1, '2023-01-02', NULL, 1), (4, 1, 0, '2023-01-02', NULL, NULL), (6, 0, 1, NULL, NULL, 1), (3, 1, 1, NULL, NULL, NULL), (NULL, 1, NULL, '2023-01-02', NULL, 1), (1, 1, NULL, '2023-01-02', NULL, NULL), (1, 1, NULL, '2023-01-01', NULL, 1), (NULL, NULL, 1, NULL, NULL, 1), (2, NULL, 0, '2023-01-01', NULL, NULL), (3, 0, 1, NULL, 1, NULL), (5, 0, 1, '2023-01-01', 1, NULL), (7, 1, 0, NULL, 1, NULL), (1, 0, 0, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(1,)
*/

-- Prediction Query
WITH T1 AS (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(1,)
*/