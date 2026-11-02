-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', NULL), (2, 'S8', 1), (1, 'S8', NULL), (-1, 'default1', 1), (3, NULL, 2), (4, 'default2', 1), (5, 'default1', 1), (6, 'iPhone', 2), (7, 'S8', 2), (8, 'S8', 1), (9, NULL, 2), (10, 'default2', NULL), (11, NULL, NULL), (12, 'default1', 1), (13, 'iPhone', 2), (14, 'iPhone', NULL), (15, 'default2', 1), (16, 'default1', NULL), (17, NULL, 1), (18, 'S8', 2), (19, 'default2', NULL), (20, 'S8', 1), (21, 'default2', NULL), (22, 'iPhone', NULL), (23, 'default2', 1), (24, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, NULL, '2023-01-01', 2, 1), (9, -1, 0, '2023-01-01', 1, NULL), (-1, 0, -1, '2023-01-02', 2, NULL), (-1, 2, NULL, '2023-01-01', 2, 2), (14, NULL, -1, '2023-01-02', 2, NULL), (13, 1, NULL, '2023-01-02', 1, 1), (15, 0, NULL, '2023-01-02', 1, 2), (23, NULL, 1, NULL, 2, 1), (19, -1, NULL, '2023-01-01', 2, 1), (10, NULL, -1, NULL, NULL, 2), (21, 0, 2, '2023-01-01', 1, 2), (19, 2, -1, '2023-01-02', 1, 2), (NULL, 1, 0, '2023-01-01', 1, 2), (12, 1, -1, '2023-01-01', NULL, NULL), (7, 2, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH S8_TAB AS (SELECT BUYER_ID FROM SALES AS SALES LEFT JOIN PRODUCT AS PROD ON SALES.PRODUCT_ID = PROD.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), IPHONE_TAB AS (SELECT BUYER_ID FROM SALES AS SALES LEFT JOIN PRODUCT AS PROD ON SALES.PRODUCT_ID = PROD.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT (BUYER_ID) FROM SALES WHERE BUYER_ID IN (SELECT * FROM S8_TAB) AND NOT BUYER_ID IN (SELECT * FROM IPHONE_TAB);

/*
Prediction Result:
*/