-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (2, 'S8', 1), (0, 'default1', NULL), (1, 'S8', NULL), (3, 'S8', NULL), (4, 'S8', 2), (5, 'S8', NULL), (6, 'S8', 1), (7, 'iPhone', 2), (8, 'default2', 1), (9, 'default1', NULL), (10, NULL, NULL), (11, NULL, NULL), (12, 'default2', NULL), (13, 'default1', NULL), (14, 'S8', NULL), (15, 'iPhone', 2), (16, 'iPhone', 1), (17, NULL, 2), (18, 'iPhone', NULL), (19, 'default1', 1), (20, 'default1', NULL), (21, 'S8', 1), (22, 'default1', NULL), (23, 'default1', NULL), (24, 'S8', 1), (25, NULL, 1), (26, NULL, 1), (27, 'default2', 2), (28, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, NULL, NULL, 1, 2), (25, -1, -1, NULL, NULL, NULL), (4, 0, -1, NULL, 1, NULL), (21, -1, 1, '2023-01-02', 1, NULL), (22, 0, 2, '2023-01-01', 1, NULL), (23, 1, 1, '2023-01-01', 1, NULL), (20, -1, 2, '2023-01-02', 2, NULL), (12, -1, 0, '2023-01-02', 2, NULL), (4, 1, 2, NULL, 1, 1), (24, 1, NULL, '2023-01-01', NULL, NULL), (5, -1, -1, NULL, NULL, 1), (16, 2, 1, '2023-01-02', 1, 2), (-1, 2, 2, '2023-01-02', 2, 2), (13, 1, NULL, '2023-01-01', 1, 1), (26, -1, -1, NULL, NULL, 2), (13, NULL, 2, '2023-01-02', 2, 2), (21, -1, 0, '2023-01-01', 1, 1), (11, NULL, 2, '2023-01-02', NULL, 2), (-1, 1, 2, '2023-01-01', NULL, 1), (27, 2, 0, '2023-01-01', 1, 1), (24, 0, 2, '2023-01-02', 1, NULL), (15, -1, -1, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
WITH S8_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), IPHONE_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone') SELECT BUYER_ID FROM SALES AS S CROSS JOIN S8_ID AS S8 CROSS JOIN IPHONE_ID AS IP GROUP BY BUYER_ID HAVING SUM(IIF(S.PRODUCT_ID = S8.PRODUCT_ID, 1, 0)) > 0 AND SUM(IIF(S.PRODUCT_ID = IP.PRODUCT_ID, 1, 0)) = 0;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/