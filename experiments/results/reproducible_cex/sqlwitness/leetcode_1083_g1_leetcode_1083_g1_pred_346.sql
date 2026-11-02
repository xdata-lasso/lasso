-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (-1, 'S8', NULL), (2, 'iPhone', 2), (1, 'S8', 1), (3, 'default1', 1), (4, 'default2', 1), (5, 'S8', 1), (6, NULL, 1), (7, 'S8', 2), (8, 'S8', NULL), (9, 'iPhone', 2), (10, 'S8', 2), (11, 'default2', 2), (12, 'iPhone', 1), (13, 'S8', NULL), (14, 'default1', NULL), (15, NULL, 2), (16, 'iPhone', 2), (17, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, -1, -1, '2023-01-02', NULL, 2), (0, 0, -1, '2023-01-02', NULL, 1), (15, 0, NULL, NULL, NULL, 2), (-1, 2, 0, '2023-01-02', 1, NULL), (16, 0, NULL, '2023-01-01', 1, NULL), (5, 2, NULL, '2023-01-01', 2, NULL), (16, 2, NULL, NULL, 2, 2), (7, 0, 2, '2023-01-01', 2, 1), (13, NULL, 2, NULL, 1, 2), (16, 2, 1, NULL, 2, NULL), (17, NULL, 2, '2023-01-02', NULL, 1), (8, 2, 0, NULL, 2, NULL), (4, NULL, 0, NULL, 1, NULL), (14, NULL, 2, '2023-01-01', NULL, NULL), (0, -1, 2, '2023-01-01', 2, 1), (10, 2, 2, '2023-01-01', 2, NULL), (9, 1, NULL, NULL, 1, 1), (4, -1, 2, NULL, 2, 1), (9, 0, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON P1.PRODUCT_ID = S1.PRODUCT_ID WHERE P1.PRODUCT_NAME = 'S8' AND NOT S1.BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/