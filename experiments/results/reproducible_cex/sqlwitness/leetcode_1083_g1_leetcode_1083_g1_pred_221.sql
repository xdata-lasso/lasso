-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 2), (1, 'iPhone', 1), (2, 'default2', 1), (-1, 'default2', 2), (3, NULL, NULL), (4, 'default1', NULL), (5, 'iPhone', 2), (6, 'default1', NULL), (7, NULL, 1), (8, 'iPhone', 1), (9, 'S8', NULL), (10, 'S8', NULL), (11, 'iPhone', 1), (12, NULL, 1), (13, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 1, 1, '2023-01-02', 1, 1), (2, 1, 2, '2023-01-01', 1, 1), (3, NULL, 2, '2023-01-02', NULL, 1), (13, 2, -1, '2023-01-01', NULL, 1), (-1, -1, 1, '2023-01-01', NULL, NULL), (10, NULL, 2, NULL, 1, NULL), (8, 1, 2, '2023-01-01', 1, 1), (5, 0, 0, NULL, NULL, NULL), (2, -1, NULL, NULL, 2, 2), (5, NULL, 2, '2023-01-02', NULL, NULL), (8, 2, NULL, NULL, 2, NULL), (6, NULL, 0, '2023-01-01', 2, 1), (0, 0, NULL, '2023-01-01', NULL, 2), (NULL, 2, 2, '2023-01-02', 1, 1), (10, 2, NULL, NULL, NULL, 2), (11, -1, 1, '2023-01-02', NULL, NULL), (11, -1, 2, NULL, 1, 2), (11, 2, 0, '2023-01-02', NULL, NULL), (13, NULL, 2, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH IPHONE_BUYER AS (SELECT DISTINCT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone'), S8_BUYER AS (SELECT DISTINCT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') SELECT BUYER_ID FROM S8_BUYER WHERE NOT BUYER_ID IN (SELECT * FROM IPHONE_BUYER);

/*
Prediction Result:
*/