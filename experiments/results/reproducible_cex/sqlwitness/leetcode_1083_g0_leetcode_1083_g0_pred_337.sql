-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (-1, 'default2', 1), (0, NULL, 2), (1, 'S8', 2), (3, 'iPhone', NULL), (4, 'default2', 2), (5, 'default1', NULL), (6, 'default1', 2), (7, 'iPhone', 2), (8, 'default1', NULL), (9, 'S8', 1), (10, NULL, 2), (11, NULL, 2), (12, 'default2', 1), (13, NULL, NULL), (14, 'iPhone', 2), (15, 'iPhone', 2), (16, NULL, 1), (17, NULL, NULL), (18, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, -1, -1, '2023-01-02', NULL, 2), (16, NULL, 0, '2023-01-01', 1, NULL), (6, -1, 2, NULL, NULL, NULL), (14, NULL, 1, '2023-01-02', NULL, 2), (16, 1, -1, NULL, 1, NULL), (7, 2, NULL, '2023-01-02', 2, 2), (12, 1, 0, NULL, 1, 1), (NULL, 2, 2, NULL, 2, 1), (2, -1, 2, '2023-01-01', 2, 2), (6, 0, 2, NULL, NULL, NULL), (13, 2, -1, '2023-01-02', NULL, 1), (4, 1, 0, '2023-01-01', 1, 2), (12, -1, -1, '2023-01-01', 2, 2), (-1, -1, 0, NULL, 1, 1), (2, -1, 0, '2023-01-02', NULL, 2), (18, NULL, 2, NULL, NULL, NULL), (4, 1, -1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH WLS AS (SELECT S.BUYER_ID, SUM(P.PRODUCT_NAME = 'S8') AS S8, SUM(P.PRODUCT_NAME = 'iPhone') AS IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) SELECT BUYER_ID FROM WLS WHERE S8 >= 1 AND IPHONE = 0;

/*
Prediction Result:
(2,)
*/