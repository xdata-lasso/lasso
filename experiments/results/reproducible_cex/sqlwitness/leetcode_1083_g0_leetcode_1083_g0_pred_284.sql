-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, 'default2', 1), (2, 'S8', 1), (3, NULL, 1), (4, NULL, 1), (5, 'default1', NULL), (6, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 0, NULL, NULL, 1), (1, 0, 1, '2023-01-02', 1, NULL), (6, 1, 0, '2023-01-02', 1, NULL), (6, NULL, NULL, '2023-01-01', 1, NULL), (1, 1, 1, NULL, 1, 1), (4, 0, NULL, '2023-01-01', 1, 1), (6, NULL, 0, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT A.*, B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone') AND BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8');

/*
Prediction Result:
(0,)
*/