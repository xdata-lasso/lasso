-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (2, 'default2', 2), (-1, 'iPhone', NULL), (1, NULL, 2), (3, 'iPhone', 2), (4, 'S8', 2), (5, 'iPhone', 1), (6, NULL, 1), (7, NULL, 1), (8, 'default1', 1), (9, NULL, NULL), (10, 'iPhone', 2), (11, NULL, 2), (12, 'S8', 1), (13, 'iPhone', 1), (14, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, -1, '2023-01-01', 2, NULL), (5, -1, 1, NULL, 2, 1), (5, -1, 0, NULL, 2, 2), (10, NULL, 1, NULL, 2, NULL), (9, NULL, NULL, '2023-01-01', NULL, 2), (-1, NULL, 0, NULL, NULL, 2), (4, 1, -1, NULL, NULL, 1), (7, 0, 1, NULL, NULL, 2), (4, 1, 0, NULL, 2, 1), (1, 1, NULL, '2023-01-02', NULL, 2), (10, 1, 0, '2023-01-02', 2, 2), (10, -1, 0, NULL, 2, 2), (-1, -1, 2, '2023-01-01', NULL, NULL), (3, -1, NULL, NULL, 1, 1), (14, NULL, 1, '2023-01-02', 2, 2), (9, NULL, 1, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH S8_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'), I_ID AS (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'), S8_BUYER AS (SELECT SALES.BUYER_ID FROM S8_ID CROSS JOIN SALES WHERE SALES.PRODUCT_ID = S8_ID.PRODUCT_ID), I_BUYER AS (SELECT SALES.BUYER_ID FROM I_ID CROSS JOIN SALES WHERE SALES.PRODUCT_ID = I_ID.PRODUCT_ID) SELECT DISTINCT (S8_BUYER.BUYER_ID) FROM S8_BUYER WHERE NOT S8_BUYER.BUYER_ID IN (SELECT BUYER_ID FROM I_BUYER);

/*
Prediction Result:
*/