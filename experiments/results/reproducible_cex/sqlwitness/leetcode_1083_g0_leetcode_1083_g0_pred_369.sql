-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (-1, 'iPhone', NULL), (0, NULL, 1), (2, NULL, NULL), (3, 'iPhone', 1), (4, 'S8', 1), (5, 'default2', NULL), (6, 'default2', NULL), (7, 'default1', NULL), (8, 'S8', 1), (9, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, -1, 1, NULL, NULL, NULL), (NULL, 1, NULL, '2023-01-02', 1, NULL), (NULL, NULL, -1, '2023-01-01', 1, NULL), (3, 0, 0, NULL, 1, 1), (7, NULL, NULL, NULL, NULL, NULL), (7, -1, 0, NULL, 1, NULL), (NULL, 0, 1, NULL, NULL, NULL), (-1, 0, NULL, '2023-01-02', NULL, NULL), (2, 1, -1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS P1 JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(1,)
*/