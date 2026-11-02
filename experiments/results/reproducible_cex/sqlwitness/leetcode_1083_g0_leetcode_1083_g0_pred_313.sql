-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'iPhone', NULL), (2, 'default2', NULL), (3, 'default2', 1), (4, 'S8', NULL), (5, 'S8', NULL), (6, 'S8', 1), (7, 'iPhone', NULL), (8, 'iPhone', 1), (9, NULL, 1), (10, 'default1', 1), (11, 'iPhone', NULL), (12, 'default2', 1), (13, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, NULL, '2023-01-02', NULL, NULL), (12, 0, 1, NULL, 1, NULL), (5, 0, 1, NULL, NULL, 1), (12, 1, 1, '2023-01-02', 1, NULL), (7, 1, NULL, '2023-01-01', 1, NULL), (9, 0, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT C1.BUYER_ID FROM CTE AS C1 LEFT JOIN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone') AS C2 ON C1.BUYER_ID = C2.BUYER_ID WHERE C1.PRODUCT_NAME = 'S8' AND C2.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(1,)
*/