-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (2, 'default1', NULL), (1, 'S8', 1), (-1, NULL, NULL), (3, 'default2', NULL), (4, 'S8', NULL), (5, 'default1', 2), (6, 'iPhone', 2), (7, 'iPhone', NULL), (8, 'default1', NULL), (9, 'S8', 1), (10, 'S8', NULL), (11, NULL, 1), (12, 'S8', 1), (13, 'S8', 2), (14, NULL, 2), (15, NULL, 1), (16, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 2, -1, NULL, 1, 1), (12, 0, NULL, '2023-01-01', 1, 2), (5, 1, NULL, '2023-01-02', 1, 2), (4, NULL, 2, NULL, NULL, NULL), (6, NULL, 0, NULL, 2, NULL), (13, NULL, NULL, '2023-01-01', NULL, 2), (NULL, -1, 1, '2023-01-01', 2, 1), (3, -1, -1, '2023-01-02', 1, NULL), (12, 2, 2, '2023-01-01', 1, NULL), (4, -1, 2, '2023-01-01', 1, 1), (4, 0, NULL, NULL, NULL, 1), (12, 2, 2, NULL, NULL, NULL), (16, 0, NULL, '2023-01-02', 1, 2), (15, 1, 0, NULL, NULL, NULL), (11, 0, NULL, '2023-01-01', 2, NULL), (6, 2, NULL, '2023-01-01', NULL, 1);
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
SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
*/