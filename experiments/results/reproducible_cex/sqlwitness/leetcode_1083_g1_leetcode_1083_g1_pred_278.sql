-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (2, 'default1', NULL), (-1, 'default1', 1), (1, NULL, 2), (3, NULL, NULL), (4, 'iPhone', 2), (5, NULL, 1), (6, NULL, 1), (7, 'default2', 2), (8, 'default1', 2), (9, 'default1', 2), (10, 'default2', 2), (11, NULL, 2), (12, 'default2', 2), (13, NULL, 1), (14, 'iPhone', 2), (15, NULL, NULL), (16, NULL, 2), (17, NULL, 1), (18, 'S8', 2), (19, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, NULL, NULL, '2023-01-01', NULL, NULL), (8, 0, 1, NULL, NULL, NULL), (18, 1, -1, '2023-01-01', NULL, NULL), (8, -1, 1, '2023-01-01', 1, 1), (4, NULL, 1, NULL, NULL, 1), (1, NULL, NULL, '2023-01-01', 2, 1), (18, -1, 2, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(2,)
*/

-- Prediction Query
WITH T1 AS (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM T1 WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/