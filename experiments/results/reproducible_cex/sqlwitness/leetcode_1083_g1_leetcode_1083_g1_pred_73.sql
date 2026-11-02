-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (0, 'iPhone', NULL), (-1, NULL, NULL), (2, 'iPhone', NULL), (3, 'S8', 2), (4, 'default2', 1), (5, NULL, 1), (6, 'S8', NULL), (7, 'iPhone', 2), (8, 'iPhone', NULL), (9, NULL, 2), (10, 'default1', 1), (11, 'default1', NULL), (12, 'default2', 2), (13, NULL, NULL), (14, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, -1, 0, '2023-01-01', 2, 1), (13, NULL, NULL, '2023-01-01', NULL, 2), (13, 2, -1, '2023-01-02', NULL, 2), (6, 2, NULL, '2023-01-02', NULL, NULL), (6, 0, 1, NULL, 1, NULL), (2, 1, NULL, NULL, 2, 2), (10, NULL, 0, NULL, 2, 2), (7, NULL, 2, '2023-01-01', 1, 2), (7, 1, 0, '2023-01-02', 2, NULL), (2, 1, 0, '2023-01-02', 2, 1), (-1, 0, 0, '2023-01-01', 2, 1), (4, NULL, 0, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT A.BUYER_ID FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8' AND NOT A.BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/