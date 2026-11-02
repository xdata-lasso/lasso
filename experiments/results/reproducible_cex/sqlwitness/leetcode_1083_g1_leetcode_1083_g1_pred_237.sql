-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (2, 'S8', NULL), (-1, 'default2', 2), (1, 'S8', NULL), (3, NULL, NULL), (4, NULL, 2), (5, 'S8', 1), (6, 'default2', 2), (7, NULL, NULL), (8, 'S8', 1), (9, 'default2', 2), (10, 'default2', 1), (11, 'S8', 2), (12, 'default1', 1), (13, NULL, 1), (14, 'iPhone', 2), (15, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, 1, '2023-01-01', NULL, NULL), (11, -1, 2, '2023-01-01', 2, NULL), (8, 0, NULL, NULL, 2, NULL), (7, 2, 2, NULL, 2, NULL), (5, 1, 0, '2023-01-01', NULL, 2), (11, -1, 1, NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
WITH TB AS (SELECT S.*, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM TB WHERE TB.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TB WHERE TB.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(2,)
(None,)
(0,)
(1,)
*/