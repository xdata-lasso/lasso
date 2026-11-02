-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (1, 'S8', 1), (2, NULL, 1), (3, 'default2', NULL), (4, 'S8', NULL), (5, 'iPhone', NULL), (6, 'S8', 1), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, 0, '2023-01-02', 1, 1), (6, 1, NULL, '2023-01-01', NULL, NULL);
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
WITH CTE AS (SELECT BUYER_ID, PRODUCT_NAME FROM PRODUCT AS P LEFT JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT (BUYER_ID) FROM CTE WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/