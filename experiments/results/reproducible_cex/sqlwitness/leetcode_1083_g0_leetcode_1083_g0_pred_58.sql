-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 2), (0, 'iPhone', 2), (2, 'default2', NULL), (1, 'iPhone', 2), (3, 'iPhone', 1), (4, 'default2', 2), (5, NULL, 1), (6, 'S8', NULL), (7, 'iPhone', NULL), (8, 'default1', NULL), (9, 'default2', 1), (10, 'default1', 1), (11, 'S8', 1), (12, 'default2', 2), (13, 'S8', 2), (14, 'default2', NULL), (15, 'default1', NULL), (16, 'default1', 1), (17, 'S8', 2), (18, 'default1', 2), (19, 'iPhone', 1), (20, NULL, 2), (21, 'default1', 1), (22, 'S8', 1), (23, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, NULL, NULL, NULL, 2), (NULL, NULL, -1, NULL, 1, 2), (6, -1, 2, '2023-01-01', NULL, 2), (23, NULL, 0, '2023-01-01', 2, 2), (3, 0, NULL, '2023-01-02', 2, 2), (9, 1, NULL, '2023-01-01', 1, 2), (2, 0, 0, NULL, NULL, NULL), (17, -1, NULL, '2023-01-02', 2, NULL), (12, 2, NULL, '2023-01-01', 2, NULL), (2, 0, NULL, '2023-01-02', 2, 1), (21, 0, NULL, '2023-01-01', 1, 2), (-1, 1, 0, NULL, NULL, 1), (14, 0, -1, '2023-01-02', NULL, NULL), (4, 1, NULL, NULL, 2, NULL), (11, NULL, 2, '2023-01-02', NULL, 2), (9, 1, NULL, '2023-01-02', 1, NULL), (6, 1, 0, NULL, NULL, NULL), (0, NULL, 0, NULL, 1, 1), (14, NULL, 0, NULL, NULL, NULL), (10, 0, 0, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) WHERE PRODUCT_NAME IN ('S8', 'iPhone') GROUP BY BUYER_ID HAVING SUM(CASE PRODUCT_NAME WHEN 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(2,)
*/