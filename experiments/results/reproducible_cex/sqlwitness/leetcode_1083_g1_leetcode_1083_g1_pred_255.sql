-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 2), (2, NULL, 1), (0, 'default2', 2), (-1, 'S8', 1), (3, 'default1', 1), (4, 'default1', 1), (5, 'S8', 1), (6, NULL, 2), (7, NULL, NULL), (8, 'iPhone', NULL), (9, 'default2', 2), (10, 'S8', NULL), (11, 'default2', 2), (12, 'default2', NULL), (13, 'default1', 2), (14, 'default1', 1), (15, NULL, 2), (16, 'iPhone', NULL), (17, NULL, 2), (18, 'S8', 2), (19, 'default2', 2), (20, NULL, 2), (21, 'S8', NULL), (22, 'default2', 1), (23, 'S8', 2), (24, 'default1', NULL), (25, 'default2', 2), (26, 'default1', 1), (27, NULL, NULL), (28, 'default2', 2), (29, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, -1, 1, '2023-01-02', 2, 1), (25, -1, -1, '2023-01-02', NULL, 1), (18, 2, 1, '2023-01-02', 2, 1), (21, 0, 1, NULL, 2, 1), (21, 1, NULL, '2023-01-01', 1, 2), (23, 0, -1, '2023-01-01', 1, 1), (16, -1, 2, '2023-01-02', NULL, 2), (14, -1, -1, '2023-01-02', NULL, NULL), (22, 0, NULL, '2023-01-02', NULL, NULL), (14, -1, 2, '2023-01-02', NULL, 1), (10, NULL, 1, '2023-01-01', 2, 1), (22, NULL, 1, '2023-01-02', NULL, NULL), (16, 1, 0, NULL, 1, 1), (0, 0, 0, '2023-01-02', 1, 1), (17, 2, 0, NULL, NULL, 1), (5, 0, 2, '2023-01-02', NULL, 2), (15, -1, 2, NULL, 2, 2), (5, NULL, -1, NULL, NULL, 2), (27, 2, 0, '2023-01-02', 1, 2), (1, 2, 1, NULL, NULL, 1), (22, 1, -1, '2023-01-02', 2, 1), (16, 0, 1, '2023-01-01', 2, 1), (19, NULL, 2, '2023-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS CNT_S8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS CNT_IPHONE FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' OR PRODUCT_NAME = 'iPhone' GROUP BY BUYER_ID) AS T WHERE CNT_S8 > 0 AND CNT_IPHONE = 0;

/*
Prediction Result:
(None,)
(-1,)
*/