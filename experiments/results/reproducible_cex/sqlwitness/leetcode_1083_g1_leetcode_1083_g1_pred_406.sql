-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', 1), (2, 'S8', 1), (0, 'default1', 2), (1, 'S8', 1), (3, 'default1', NULL), (4, 'default2', 2), (5, NULL, 2), (6, NULL, 2), (7, 'default2', 1), (8, 'default1', 1), (9, 'default2', NULL), (10, 'default2', 1), (11, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 0, '2023-01-02', 1, NULL), (1, NULL, 2, '2023-01-02', 1, 2), (6, 0, 0, NULL, NULL, NULL), (1, NULL, -1, NULL, 2, NULL), (-1, 1, -1, '2023-01-01', 2, NULL), (7, 0, 2, '2023-01-02', 1, 1), (8, 0, 1, NULL, NULL, NULL), (6, -1, -1, '2023-01-01', NULL, 2), (1, NULL, NULL, '2023-01-02', 2, 2), (6, 2, -1, '2023-01-01', 2, NULL), (2, 2, -1, '2023-01-02', 1, 2), (8, 0, -1, '2023-01-02', 2, NULL), (8, 1, 0, '2023-01-02', 2, 1), (9, 0, 1, NULL, NULL, NULL), (9, 2, 0, '2023-01-01', NULL, 2), (NULL, 2, 0, '2023-01-01', 1, 1), (4, 2, -1, '2023-01-02', NULL, 1), (10, NULL, -1, '2023-01-01', 2, 2);
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
SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0 AND SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0;

/*
Prediction Result:
(None,)
(-1,)
(2,)
*/