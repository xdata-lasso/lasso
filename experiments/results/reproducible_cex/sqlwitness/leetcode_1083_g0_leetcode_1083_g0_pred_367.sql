-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 2), (-1, 'S8', 1), (1, 'iPhone', 1), (0, 'iPhone', NULL), (3, 'default1', NULL), (4, 'S8', 2), (5, NULL, NULL), (6, 'iPhone', 1), (7, 'default2', 2), (8, 'S8', 1), (9, 'S8', NULL), (10, 'iPhone', NULL), (11, NULL, NULL), (12, 'iPhone', 1), (13, 'default1', NULL), (14, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, 1, '2023-01-01', 1, 1), (13, NULL, 1, NULL, 2, 2), (7, 0, 0, '2023-01-01', NULL, 1), (5, 0, NULL, '2023-01-02', 1, NULL), (0, NULL, 2, '2023-01-01', 1, 2), (14, 1, 1, NULL, NULL, 1), (8, NULL, NULL, '2023-01-02', 2, NULL), (0, 0, NULL, '2023-01-02', NULL, 1), (13, 2, -1, '2023-01-01', 1, NULL), (11, -1, -1, '2023-01-02', 1, 1), (5, -1, 1, '2023-01-01', 2, 2), (11, 2, NULL, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) AS V WHERE V.S8 > 0 AND V.IPHONE = 0;

/*
Prediction Result:
(1,)
*/