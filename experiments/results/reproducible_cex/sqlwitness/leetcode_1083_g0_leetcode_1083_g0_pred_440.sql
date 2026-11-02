-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (-1, 'default1', 1), (1, 'default2', NULL), (2, 'default1', NULL), (3, 'S8', NULL), (4, NULL, 1), (5, 'default2', 1), (6, NULL, NULL), (7, 'iPhone', NULL), (8, NULL, 1), (9, 'default2', NULL), (10, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, -1, '2023-01-02', 1, 1), (-1, -1, -1, NULL, NULL, 1), (NULL, -1, 1, NULL, 1, NULL), (0, NULL, 0, '2023-01-02', NULL, 1), (3, 1, -1, '2023-01-02', 1, 1), (2, 1, 0, '2023-01-01', 1, NULL), (3, 0, 0, NULL, 1, NULL), (7, 1, NULL, '2023-01-02', 1, 1), (0, 0, 0, '2023-01-01', NULL, NULL), (-1, NULL, 0, NULL, 1, NULL), (2, NULL, -1, '2023-01-01', NULL, NULL), (NULL, 1, 1, '2023-01-01', 1, NULL), (10, NULL, 1, '2023-01-02', NULL, 1), (4, NULL, -1, NULL, NULL, NULL), (3, NULL, 1, '2023-01-02', 1, NULL), (2, 1, NULL, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(PRODUCT_NAME = 'S8') AS TOTAL_S8, SUM(PRODUCT_NAME = 'iPhone') AS TOTAL_IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) AS SUB WHERE TOTAL_S8 > 0 AND TOTAL_IPHONE = 0;

/*
Prediction Result:
(-1,)
(0,)
*/