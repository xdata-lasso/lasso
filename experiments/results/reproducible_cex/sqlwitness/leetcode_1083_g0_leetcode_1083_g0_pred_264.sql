-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'S8', 2), (2, 'default1', 1), (-1, 'default2', 1), (3, 'iPhone', NULL), (4, NULL, 2), (5, 'S8', 2), (6, 'default1', 1), (7, 'iPhone', NULL), (8, 'S8', 2), (9, NULL, 2), (10, 'default1', 1), (11, NULL, NULL), (12, 'iPhone', 2), (13, 'iPhone', NULL), (14, 'default1', NULL), (15, NULL, 2), (16, 'S8', NULL), (17, 'S8', 1), (18, 'S8', 1), (19, 'iPhone', NULL), (20, 'default1', 2), (21, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (18, 1, 2, '2023-01-01', NULL, 2), (21, 2, -1, '2023-01-02', NULL, NULL), (5, 2, 0, '2023-01-01', NULL, 2), (0, -1, -1, '2023-01-01', NULL, 2), (NULL, -1, 0, '2023-01-02', NULL, 2), (-1, NULL, 1, '2023-01-02', NULL, NULL), (19, 1, 0, '2023-01-01', NULL, 2), (0, 2, 2, NULL, 1, 2), (4, -1, NULL, '2023-01-01', 1, 2), (21, 0, NULL, '2023-01-02', 2, 1), (4, 2, NULL, '2023-01-01', 1, 1), (5, -1, -1, NULL, 2, 2), (4, -1, 2, '2023-01-02', NULL, NULL), (21, -1, 1, '2023-01-01', 1, 1), (17, -1, -1, '2023-01-02', 1, 2), (0, 1, 1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH X AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLG, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHN_FLG FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM X WHERE S8_FLG >= 1 AND IPHN_FLG = 0;

/*
Prediction Result:
(2,)
*/