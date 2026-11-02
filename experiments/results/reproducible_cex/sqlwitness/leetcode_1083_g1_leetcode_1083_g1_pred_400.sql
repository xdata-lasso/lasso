-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (-1, 'iPhone', 1), (0, 'iPhone', NULL), (1, NULL, 1), (3, 'default2', NULL), (4, 'default1', 1), (5, 'default2', NULL), (6, 'default2', 1), (7, NULL, 2), (8, 'iPhone', 2), (9, 'default2', 1), (10, 'default1', 1), (11, NULL, 2), (12, NULL, 1), (13, 'S8', NULL), (14, NULL, NULL), (15, NULL, 2), (16, 'default2', NULL), (17, 'iPhone', NULL), (18, 'S8', 2), (19, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, -1, NULL, NULL, 1, 1), (12, 1, 1, '2023-01-01', NULL, 2), (0, 1, NULL, NULL, 1, NULL), (1, -1, NULL, '2023-01-01', 2, 1), (8, 1, 0, NULL, 2, NULL), (18, NULL, 2, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.*, B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'iPhone') ORDER BY BUYER_ID;

/*
Prediction Result:
*/