-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 2), (2, 'S8', 2), (-1, 'iPhone', NULL), (0, NULL, 1), (3, 'S8', 1), (4, NULL, 1), (5, 'default2', NULL), (6, 'default2', NULL), (7, 'default2', 1), (8, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, NULL, NULL, '2023-01-02', 1, 2), (1, 0, NULL, '2023-01-01', 1, 2), (5, 2, 2, '2023-01-01', 2, 1), (0, -1, 0, '2023-01-02', NULL, NULL), (6, 2, 2, '2023-01-01', 1, 1), (8, 2, NULL, '2023-01-02', 1, NULL), (3, NULL, 2, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH BIG_TABLE AS (SELECT P.PRODUCT_NAME, S.PRODUCT_ID, S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID), S8 AS (SELECT BUYER_ID FROM BIG_TABLE WHERE PRODUCT_NAME = 'S8'), IPHONES AS (SELECT BUYER_ID FROM BIG_TABLE WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT * FROM S8) AND NOT BUYER_ID IN (SELECT * FROM IPHONES);

/*
Prediction Result:
*/