-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 1), (1, 'default1', 1), (-1, 'S8', NULL), (0, 'S8', NULL), (3, 'S8', 1), (4, 'default2', NULL), (5, 'default1', 2), (6, 'default2', 2), (7, NULL, 1), (8, 'S8', NULL), (9, 'default1', 1), (10, 'iPhone', NULL), (11, 'default1', 1), (12, 'S8', 1), (13, NULL, 1), (14, 'S8', NULL), (15, 'S8', 2), (16, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 0, NULL, 1, 1), (3, 0, 2, '2023-01-02', 1, NULL), (-1, 1, 1, NULL, NULL, 2), (2, 1, -1, NULL, 2, NULL), (13, 2, -1, '2023-01-02', NULL, 2), (15, 2, NULL, NULL, NULL, 1), (NULL, 0, 0, NULL, NULL, NULL), (5, -1, -1, NULL, 1, 1), (2, NULL, -1, NULL, NULL, NULL), (3, 0, -1, '2023-01-01', NULL, 1), (16, 1, 1, '2023-01-01', NULL, NULL), (15, -1, 2, '2023-01-01', 1, 2), (5, 0, -1, NULL, NULL, 1), (4, 1, 2, '2023-01-02', 1, NULL), (9, 2, NULL, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT (S.BUYER_ID) FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT DISTINCT (S2.BUYER_ID) FROM SALES AS S2 INNER JOIN PRODUCT AS P2 ON S2.PRODUCT_ID = P2.PRODUCT_ID AND P2.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
(2,)
(1,)
(-1,)
(None,)
*/