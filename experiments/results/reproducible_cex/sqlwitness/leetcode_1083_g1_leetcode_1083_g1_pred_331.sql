-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (-1, NULL, 2), (0, NULL, 1), (2, 'default2', 2), (3, 'default1', 1), (4, NULL, NULL), (5, 'iPhone', 1), (6, NULL, NULL), (7, 'default1', NULL), (8, 'default2', 2), (9, 'S8', NULL), (10, 'default2', 1), (11, 'iPhone', 2), (12, 'default2', NULL), (13, NULL, NULL), (14, NULL, 2), (15, 'iPhone', 2), (16, 'S8', 1), (17, 'iPhone', 1), (18, NULL, 2), (19, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, 0, 1, '2023-01-01', NULL, NULL), (-1, 0, -1, '2023-01-01', NULL, 1), (19, NULL, 1, '2023-01-01', 2, 1), (19, 1, NULL, '2023-01-02', 2, NULL), (15, 1, 2, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT A.BUYER_ID, SUM(CASE WHEN B.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN B.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IOS FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY BUYER_ID) AS A WHERE S8 >= 1 AND IOS = 0;

/*
Prediction Result:
(None,)
(1,)
*/