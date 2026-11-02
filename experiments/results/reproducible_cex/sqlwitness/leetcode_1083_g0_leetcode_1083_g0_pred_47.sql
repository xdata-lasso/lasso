-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', NULL), (1, NULL, 2), (2, 'S8', NULL), (0, NULL, NULL), (3, 'S8', 1), (4, 'iPhone', 2), (5, 'default1', NULL), (6, NULL, 1), (7, 'default1', NULL), (8, NULL, 2), (9, 'iPhone', 2), (10, 'iPhone', 2), (11, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, 0, '2023-01-02', 2, 2), (-1, 0, 0, NULL, 1, 1), (8, NULL, -1, '2023-01-01', 2, NULL), (7, 0, 0, NULL, 2, 2), (2, NULL, 2, '2023-01-01', NULL, 1), (10, 2, -1, '2023-01-01', 1, 2), (NULL, 1, NULL, '2023-01-01', NULL, 1), (0, NULL, -1, '2023-01-01', 2, 1), (9, 2, NULL, NULL, 1, 1), (11, 1, -1, NULL, NULL, 1), (5, NULL, 2, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(IIF(PRODUCT_NAME = 'S8', 1, 0)) > 0 AND SUM(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(2,)
*/