-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 1), (0, NULL, 1), (1, 'iPhone', 1), (-1, 'S8', NULL), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default1', 1), (6, 'default2', NULL), (7, 'iPhone', 1), (8, 'iPhone', 1), (9, 'iPhone', 1), (10, 'default1', 2), (11, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, -1, 1, '2023-01-02', NULL, 2), (5, 1, NULL, '2023-01-02', NULL, 2), (NULL, NULL, 0, '2023-01-01', NULL, 1), (0, -1, 1, '2023-01-01', 2, 2), (6, NULL, -1, NULL, 1, 1), (2, 0, 2, '2023-01-01', NULL, NULL), (1, NULL, 0, '2023-01-01', 2, 1), (3, -1, 2, '2023-01-01', 2, 1), (-1, NULL, 1, NULL, 2, 1), (7, 0, 1, '2023-01-02', 2, 1), (10, -1, NULL, '2023-01-01', 1, NULL), (8, -1, 0, NULL, 2, NULL), (7, -1, 1, '2023-01-01', NULL, 2), (1, 1, 0, NULL, 1, NULL), (7, 0, -1, NULL, 2, 2), (10, NULL, 0, '2023-01-02', 1, 1), (2, NULL, 0, '2023-01-01', 2, 2), (7, NULL, NULL, '2023-01-01', 1, NULL), (9, 0, NULL, '2023-01-02', NULL, 2), (6, 2, 0, NULL, 2, NULL), (1, 2, 1, NULL, 1, 2), (11, NULL, NULL, '2023-01-02', NULL, 2), (10, 2, 1, NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/