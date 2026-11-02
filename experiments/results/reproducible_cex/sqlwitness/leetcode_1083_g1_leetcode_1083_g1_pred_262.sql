-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (-1, 'default2', 1), (1, 'S8', 2), (2, NULL, NULL), (3, 'S8', NULL), (4, 'S8', NULL), (5, 'S8', 1), (6, 'S8', NULL), (7, 'default2', 1), (8, 'S8', NULL), (9, 'S8', 1), (10, 'S8', NULL), (11, 'default2', 1), (12, 'default1', 1), (13, 'S8', 1), (14, NULL, 2), (15, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, 1, 0, '2023-01-02', 1, 2), (9, 0, NULL, '2023-01-02', 2, 2), (5, 2, 0, '2023-01-02', NULL, NULL), (NULL, 1, 1, '2023-01-01', NULL, 2), (15, 1, 0, '2023-01-01', NULL, 1), (7, NULL, NULL, '2023-01-01', 2, NULL), (14, 2, 1, NULL, 2, 1), (5, 1, 1, '2023-01-02', 1, 2), (1, 1, NULL, '2023-01-02', 2, 2), (6, -1, 2, '2023-01-02', 1, 2);
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
SELECT DISTINCT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT S1.BUYER_ID FROM PRODUCT AS P1 JOIN SALES AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
(0,)
(1,)
(2,)
*/