-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'S8', 1), (-1, 'S8', 1), (2, 'default2', NULL), (3, 'default2', NULL), (4, 'default2', 1), (5, 'iPhone', 1), (6, 'default2', NULL), (7, 'iPhone', 1), (8, 'default1', 1), (9, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, NULL, NULL, 1, 1), (-1, -1, 1, '2023-01-01', 1, NULL), (NULL, NULL, NULL, NULL, NULL, NULL), (1, -1, -1, '2023-01-01', 1, 1), (1, -1, 1, NULL, 1, 1), (7, -1, 1, '2023-01-02', NULL, 1), (5, 1, 1, '2023-01-01', NULL, 1), (-1, NULL, 1, '2023-01-01', NULL, 1), (-1, 1, 0, '2023-01-01', NULL, NULL), (0, NULL, 0, '2023-01-02', NULL, 1), (7, 1, -1, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(P1.PRODUCT_NAME = 'S8') > 0 AND SUM(P1.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(0,)
*/