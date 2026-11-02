-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 1), (1, 'iPhone', 2), (-1, 'S8', NULL), (0, 'S8', 1), (3, 'iPhone', NULL), (4, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 2, NULL, '2023-01-01', NULL, 1), (2, -1, 1, '2023-01-02', 1, 1), (4, 0, -1, '2023-01-02', 2, NULL), (3, -1, 0, NULL, 2, 2), (4, 1, 1, '2023-01-01', NULL, 2), (0, -1, 1, NULL, 2, NULL), (1, 2, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID)), CTE2 AS (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLAG, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IP_FLAG FROM CTE GROUP BY BUYER_ID HAVING S8_FLAG >= 1 AND IP_FLAG = 0) SELECT BUYER_ID FROM CTE2;

/*
Prediction Result:
(None,)
*/