-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 2), (0, 'default1', NULL), (1, 'default1', NULL), (-1, 'iPhone', 2), (3, 'iPhone', 1), (4, 'S8', NULL), (5, 'default1', 1), (6, 'iPhone', 1), (7, 'default1', 2), (8, 'iPhone', NULL), (9, 'iPhone', 1), (10, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, -1, -1, NULL, 1, 1), (10, 0, -1, '2023-01-02', 2, NULL), (3, 0, 0, '2023-01-01', 2, 1), (1, -1, NULL, '2023-01-01', 2, 2), (6, -1, 0, '2023-01-01', 1, NULL), (5, 0, 1, '2023-01-01', 1, 2), (3, 0, NULL, NULL, 1, 2), (5, 2, 1, '2023-01-01', 2, NULL), (10, -1, NULL, '2023-01-02', 1, NULL), (10, 2, 1, '2023-01-02', 1, 2), (5, -1, 2, '2023-01-01', 2, 2), (4, 1, -1, '2023-01-02', 1, 2), (2, 2, NULL, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH BOUGHT_S8 AS (SELECT DISTINCT BUYER_ID, PRODUCT_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) SELECT BUYER_ID FROM BOUGHT_S8 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
*/