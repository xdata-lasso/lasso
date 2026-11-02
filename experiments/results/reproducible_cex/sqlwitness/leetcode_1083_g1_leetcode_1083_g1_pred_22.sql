-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 2), (2, 'iPhone', NULL), (-1, 'S8', 2), (0, 'S8', 2), (3, 'default1', NULL), (4, 'iPhone', 2), (5, 'default1', NULL), (6, 'default2', 1), (7, 'iPhone', 2), (8, 'S8', 2), (9, 'iPhone', 1), (10, 'default2', NULL), (11, 'default1', 1), (12, 'default2', 2), (13, 'iPhone', 2), (14, 'default2', 1), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, -1, 1, NULL, NULL, 2), (10, 1, 2, '2023-01-02', NULL, 1), (4, NULL, 2, '2023-01-02', 1, 2), (-1, NULL, -1, '2023-01-02', NULL, 1), (13, 0, NULL, '2023-01-02', 2, 2), (8, -1, 1, '2023-01-02', 1, 2), (15, -1, 2, '2023-01-01', 2, 1), (1, 2, 1, '2023-01-01', 2, NULL), (14, 1, -1, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/