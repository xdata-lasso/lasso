-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'S8', 1), (2, 'default2', 1), (3, NULL, NULL), (4, NULL, 1), (5, 'default2', NULL), (6, 'iPhone', 1), (7, NULL, NULL), (8, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, NULL, '2023-01-02', 1, NULL), (7, 0, 0, NULL, NULL, 1), (1, 0, 0, NULL, 1, 1), (1, 0, 1, NULL, 1, NULL), (8, NULL, 1, '2023-01-01', NULL, NULL), (1, NULL, 1, '2023-01-02', NULL, 1), (NULL, 1, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT DISTINCT S1.BUYER_ID FROM PRODUCT AS P1 LEFT JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/