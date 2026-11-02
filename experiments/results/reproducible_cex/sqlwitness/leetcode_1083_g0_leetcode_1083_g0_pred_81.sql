-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'S8', NULL), (2, 'default2', NULL), (3, NULL, NULL), (4, NULL, NULL), (5, 'default1', 1), (6, 'iPhone', 1), (7, NULL, 1), (8, 'default1', NULL), (9, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, NULL, '2023-01-02', 1, 1), (8, 1, 0, NULL, 1, NULL), (NULL, 1, NULL, '2023-01-01', 1, 1), (8, 1, 1, '2023-01-02', NULL, 1), (NULL, 1, NULL, '2023-01-01', NULL, 1), (4, 1, 1, '2023-01-02', NULL, 1), (0, 0, 1, NULL, NULL, NULL), (3, 0, 1, '2023-01-01', 1, 1), (8, 1, 0, '2023-01-01', 1, 1), (9, NULL, 1, '2023-01-01', 1, NULL), (NULL, 1, NULL, NULL, 1, 1), (1, 0, 1, '2023-01-02', 1, NULL), (NULL, 1, 1, NULL, NULL, NULL), (6, 1, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT (BUYER_ID) FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'iPhone'), TEMP AS (SELECT DISTINCT (BUYER_ID) FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_NAME = 'S8') SELECT T.BUYER_ID FROM TEMP AS T LEFT JOIN CTE AS C ON T.BUYER_ID = C.BUYER_ID WHERE C.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/