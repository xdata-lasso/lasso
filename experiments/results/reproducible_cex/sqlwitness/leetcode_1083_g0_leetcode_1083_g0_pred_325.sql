-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', NULL), (0, 'default2', NULL), (-1, 'iPhone', NULL), (1, 'iPhone', 1), (3, 'iPhone', 1), (4, 'S8', 1), (5, 'S8', NULL), (6, 'iPhone', 1), (7, 'default2', 2), (8, 'default1', 2), (9, 'default2', NULL), (10, 'default2', 2), (11, NULL, 1), (12, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 1, '2023-01-02', 1, 2), (6, NULL, -1, '2023-01-01', 2, 1), (8, 2, 1, '2023-01-01', 1, 1), (3, -1, 1, '2023-01-01', NULL, NULL), (-1, 2, NULL, '2023-01-02', 1, 2), (5, 2, 0, NULL, NULL, 2), (11, NULL, 1, NULL, NULL, 2), (NULL, 0, NULL, '2023-01-02', NULL, 1), (4, 0, 0, '2023-01-01', 1, NULL), (9, 0, 1, NULL, 1, 2), (12, -1, 0, '2023-01-01', 2, 2), (10, 1, 2, NULL, 2, NULL), (11, 1, 0, '2023-01-02', 2, 1), (3, 1, 1, '2023-01-02', NULL, NULL), (3, 2, NULL, NULL, 2, 2), (4, 0, 1, '2023-01-01', 2, 2), (10, NULL, 2, '2023-01-01', 2, NULL), (2, 2, 1, '2023-01-01', 1, 1), (-1, 2, 2, '2023-01-01', 1, NULL), (6, 2, NULL, '2023-01-01', 1, NULL), (4, 1, NULL, NULL, 2, NULL), (8, NULL, -1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CNT AS (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) SELECT BUYER_ID FROM CNT WHERE S8 > 0 AND IPHONE = 0;

/*
Prediction Result:
(0,)
*/