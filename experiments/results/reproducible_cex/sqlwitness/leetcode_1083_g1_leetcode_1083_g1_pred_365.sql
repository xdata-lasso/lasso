-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (2, NULL, 1), (0, NULL, 2), (-1, 'default2', 2), (3, NULL, 2), (4, 'iPhone', 2), (5, 'default2', NULL), (6, NULL, 1), (7, 'iPhone', 2), (8, NULL, 2), (9, 'default2', 1), (10, NULL, 1), (11, 'default2', 1), (12, NULL, NULL), (13, NULL, 1), (14, 'S8', 1), (15, 'S8', 1), (16, NULL, 2), (17, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 2, 2, '2023-01-01', 1, 2), (2, -1, -1, NULL, NULL, 2), (4, -1, 2, NULL, 2, NULL), (1, NULL, 1, NULL, 2, NULL), (4, 1, 1, '2023-01-01', 1, 2), (-1, 1, NULL, NULL, 2, 1), (3, 2, 0, '2023-01-02', 2, 2), (8, 1, NULL, '2023-01-01', 1, NULL), (NULL, NULL, -1, '2023-01-01', 1, 2), (0, -1, 1, '2023-01-01', NULL, 2), (10, 2, 1, '2023-01-01', 2, NULL), (2, NULL, 1, '2023-01-02', 1, NULL), (15, -1, NULL, '2023-01-01', NULL, NULL), (6, 0, -1, NULL, 2, 2), (11, -1, 0, '2023-01-02', NULL, 2), (1, -1, 2, '2023-01-02', 2, NULL), (1, NULL, -1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(P1.PRODUCT_NAME = 'S8') > 0 AND SUM(P1.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/