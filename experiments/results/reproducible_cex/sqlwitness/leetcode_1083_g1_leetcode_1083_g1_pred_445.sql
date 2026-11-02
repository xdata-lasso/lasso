-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 2), (0, 'S8', 2), (1, NULL, 1), (-1, 'default2', 2), (3, 'S8', NULL), (4, 'default1', 2), (5, 'default2', 1), (6, 'default1', 2), (7, 'default2', NULL), (8, 'iPhone', 1), (9, 'default2', 2), (10, 'default2', 1), (11, 'default2', NULL), (12, NULL, 1), (13, 'default2', 2), (14, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, NULL, 1, '2023-01-01', 2, NULL), (4, NULL, 0, '2023-01-02', 1, NULL), (-1, 0, 1, '2023-01-01', 1, NULL), (11, 2, 1, '2023-01-01', NULL, 1), (3, 1, 0, '2023-01-02', 2, 1), (0, -1, NULL, '2023-01-01', NULL, 2), (9, 1, 2, '2023-01-02', 1, NULL), (2, 1, 2, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8 FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING S8 > 0 AND IPHONE = 0) AS T;

/*
Prediction Result:
(None,)
(0,)
*/