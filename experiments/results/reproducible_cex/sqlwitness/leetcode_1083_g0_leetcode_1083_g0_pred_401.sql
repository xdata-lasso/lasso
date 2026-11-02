-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (2, 'default2', 1), (0, 'iPhone', 2), (-1, 'default2', 2), (3, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 1, NULL, NULL, 1), (NULL, 1, 2, '2023-01-01', 2, NULL), (0, 0, NULL, NULL, 2, 2), (NULL, 0, 2, NULL, 1, 2), (1, NULL, -1, '2023-01-01', NULL, 2), (2, NULL, -1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH TB1 AS (SELECT A.BUYER_ID, MAX(CASE WHEN B.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS IND_S8, MAX(CASE WHEN B.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IND_PHN FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM TB1 WHERE IND_S8 = 1 AND IND_PHN = 0;

/*
Prediction Result:
(1,)
*/