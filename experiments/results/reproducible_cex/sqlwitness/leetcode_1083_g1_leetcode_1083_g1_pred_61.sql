-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, NULL, 1), (2, 'iPhone', NULL), (-1, 'default2', NULL), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'default2', 1), (6, 'default1', 1), (7, 'S8', 2), (8, NULL, 1), (9, 'default2', 2), (10, 'iPhone', 1), (11, 'iPhone', 2), (12, 'S8', NULL), (13, 'iPhone', 2), (14, 'default1', 2), (15, 'S8', 1), (16, 'default2', 2), (17, 'iPhone', 2), (18, 'default1', NULL), (19, 'S8', 1), (20, 'iPhone', 1), (21, 'default2', NULL), (22, 'default1', 2), (23, 'iPhone', NULL), (24, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, -1, 1, '2023-01-01', NULL, 2), (11, NULL, NULL, NULL, 2, NULL), (19, NULL, 1, '2023-01-01', NULL, NULL), (19, 2, 2, NULL, 1, 2), (7, 1, 1, '2023-01-01', 1, NULL), (15, -1, 2, '2023-01-02', 1, 2), (9, 1, 0, '2023-01-02', 1, 1), (0, 0, NULL, '2023-01-02', 1, 1), (22, NULL, NULL, NULL, NULL, NULL), (-1, 0, NULL, '2023-01-02', NULL, 2), (22, 2, 0, '2023-01-01', NULL, 2), (13, 2, 0, '2023-01-01', 2, 1), (7, 2, 2, NULL, NULL, 1), (22, 1, -1, '2023-01-02', 1, 1), (19, 2, 0, NULL, 1, 1), (21, 2, 2, '2023-01-02', 2, 1), (16, NULL, -1, NULL, NULL, 2), (5, 1, NULL, '2023-01-02', 2, 1), (21, NULL, 2, '2023-01-02', NULL, 1), (17, NULL, NULL, '2023-01-01', NULL, 1), (16, 0, 2, '2023-01-02', 1, NULL), (22, 2, 1, NULL, 1, 2), (-1, 0, NULL, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S WHERE BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/