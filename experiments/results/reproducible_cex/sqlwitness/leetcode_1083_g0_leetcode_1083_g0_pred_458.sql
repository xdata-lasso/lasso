-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 1), (1, 'S8', 1), (0, 'default1', 1), (2, 'iPhone', 1), (3, 'default1', 1), (4, 'default2', NULL), (5, 'S8', 1), (6, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, NULL, '2023-01-02', 1, 1), (6, 0, 0, NULL, 1, NULL), (-1, 0, NULL, NULL, NULL, NULL), (5, NULL, -1, NULL, NULL, 1), (0, 0, 0, '2023-01-02', 1, NULL), (1, NULL, -1, '2023-01-01', 1, 1), (-1, NULL, 0, NULL, NULL, 1), (NULL, NULL, NULL, NULL, 1, NULL), (4, NULL, 1, NULL, NULL, NULL), (5, -1, 1, NULL, 1, NULL), (3, -1, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(PRODUCT_NAME = 'S8') AS S_S8, SUM(PRODUCT_NAME = 'iPhone') AS S_IPHONE FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID) AS X GROUP BY BUYER_ID) AS Y WHERE S_S8 > 0 AND S_IPHONE = 0;

/*
Prediction Result:
(-1,)
(1,)
*/