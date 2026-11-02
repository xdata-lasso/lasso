-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, 'iPhone', 1), (2, 'IPHONE ', 1), (3, 'S8', 1), (4, 'iPhone', NULL), (5, 'S8', NULL), (6, NULL, NULL), (7, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, 0, '2023-01-02', 1, NULL), (3, 1, NULL, '2023-01-01', NULL, 1), (6, 0, 0, '2023-01-01', 1, 1), (NULL, NULL, 0, NULL, 1, 1), (5, NULL, 0, '2023-01-01', NULL, 1), (3, NULL, 1, '2023-01-02', 1, NULL), (7, 0, 1, '2023-01-02', 1, 1), (5, 1, 1, NULL, 1, 1), (4, 1, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CTE AS (SELECT S.SELLER_ID, S.BUYER_ID, P.PRODUCT_NAME, P.PRODUCT_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME IN ('S8', 'iPhone')) SELECT DISTINCT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'IPHONE ');

/*
Prediction Result:
(None,)
(0,)
(1,)
*/