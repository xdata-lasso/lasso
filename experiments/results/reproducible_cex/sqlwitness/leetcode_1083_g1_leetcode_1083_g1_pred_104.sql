-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 2), (0, NULL, 1), (1, NULL, 1), (2, 'iPhone', NULL), (3, 'S8', NULL), (4, 'iPhone', 2), (5, 'default1', 1), (6, NULL, 2), (7, 'iPhone', 1), (8, NULL, NULL), (9, 'S8', 1), (10, 'default1', NULL), (11, 'iPhone', NULL), (12, 'iPhone', NULL), (13, 'default2', NULL), (14, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, 0, '2023-01-02', 2, 1), (6, 1, NULL, '2023-01-01', NULL, 2), (2, 1, 1, '2023-01-02', NULL, 1), (3, -1, NULL, NULL, 1, 2), (12, -1, 0, '2023-01-02', NULL, 1), (1, 0, 2, NULL, 1, 2), (8, 1, NULL, '2023-01-01', NULL, 1), (6, 1, 1, '2023-01-02', NULL, NULL), (NULL, NULL, 0, '2023-01-01', 1, NULL), (14, -1, 1, NULL, 1, 1), (-1, 0, NULL, '2023-01-02', 1, 2), (11, 0, NULL, '2023-01-01', 1, NULL), (13, NULL, 0, '2023-01-01', NULL, 2), (8, 0, 2, NULL, 1, NULL), (14, 2, 1, '2023-01-02', NULL, 1), (9, 1, 0, '2023-01-01', 2, 1), (11, 0, NULL, '2023-01-01', 1, 1), (7, 1, -1, '2023-01-01', 2, 1), (3, 2, 2, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT * FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID)) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/