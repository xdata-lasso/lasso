-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 2), (2, NULL, NULL), (-1, 'iPhone', 1), (1, NULL, 1), (3, 'default2', 2), (4, NULL, 1), (5, 'default1', NULL), (6, 'iPhone', NULL), (7, 'default2', 2), (8, 'default1', 1), (9, 'default2', 2), (10, 'iPhone', NULL), (11, 'iPhone', 1), (12, 'default2', 1), (13, 'S8', 1), (14, 'default1', 2), (15, 'default2', 1), (16, NULL, 2), (17, 'default2', 2), (18, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (18, 2, 2, '2023-01-01', NULL, 1), (NULL, 1, 0, '2023-01-01', 2, NULL), (15, 1, 2, NULL, 1, 2), (14, -1, 2, NULL, NULL, 2), (-1, 2, -1, NULL, 2, 2), (14, -1, NULL, '2023-01-02', 2, 2), (1, 0, 2, NULL, 1, 2), (17, 2, 1, NULL, 1, 1), (8, NULL, 0, '2023-01-02', 2, NULL), (16, 2, 2, '2023-01-01', 1, NULL), (13, 2, NULL, '2023-01-02', 2, 2), (5, 2, -1, NULL, 2, 2), (NULL, NULL, 1, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS P1 JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
*/