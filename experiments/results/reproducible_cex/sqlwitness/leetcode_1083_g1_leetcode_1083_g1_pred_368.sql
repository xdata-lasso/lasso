-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 2), (0, 'S8', 1), (2, 'iPhone', NULL), (1, 'default2', NULL), (3, 'S8', 2), (4, 'default2', NULL), (5, 'S8', NULL), (6, 'default1', 2), (7, 'S8', NULL), (8, 'default2', 2), (9, 'default1', 1), (10, NULL, NULL), (11, 'default1', NULL), (12, 'S8', 1), (13, NULL, 2), (14, 'default1', 1), (15, 'default1', 1), (16, 'S8', NULL), (17, NULL, 1), (18, 'S8', 2), (19, NULL, 1), (20, NULL, NULL), (21, 'default1', NULL), (22, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (15, 2, 0, '2023-01-01', 2, NULL), (6, -1, 2, '2023-01-02', 1, NULL), (16, NULL, 1, '2023-01-01', 2, NULL), (19, NULL, 1, NULL, 1, 2), (14, 0, NULL, '2023-01-01', 1, NULL), (7, NULL, NULL, '2023-01-02', NULL, NULL), (9, 0, -1, NULL, 1, 1), (14, 1, 0, '2023-01-01', 2, 1), (4, 2, -1, '2023-01-01', NULL, NULL), (5, 1, 2, '2023-01-01', NULL, 2), (13, 2, 0, NULL, NULL, NULL), (2, 2, 1, '2023-01-01', 2, 1), (22, 1, NULL, NULL, 1, NULL), (12, -1, 1, '2023-01-01', 1, 2), (NULL, -1, NULL, '2023-01-02', 1, 2), (11, 0, 1, NULL, 2, 2), (2, NULL, 0, NULL, 2, 1), (13, 0, -1, NULL, NULL, NULL), (13, NULL, 0, '2023-01-01', 2, 1), (21, 1, 2, '2023-01-01', 1, 2), (19, NULL, -1, '2023-01-01', NULL, 2), (4, 1, 0, '2023-01-01', 2, 2), (7, -1, NULL, '2023-01-01', NULL, NULL), (11, NULL, 0, NULL, NULL, 1), (4, 0, NULL, '2023-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) AS V WHERE V.S8 > 0 AND V.IPHONE = 0;

/*
Prediction Result:
(None,)
(2,)
*/