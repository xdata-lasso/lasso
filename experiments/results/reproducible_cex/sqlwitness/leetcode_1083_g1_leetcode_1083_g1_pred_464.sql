-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (2, 'default1', 2), (0, 'default1', 1), (-1, 'S8', 2), (3, NULL, NULL), (4, 'iPhone', 2), (5, NULL, NULL), (6, 'default2', NULL), (7, NULL, 1), (8, NULL, NULL), (9, 'default2', 1), (10, 'iPhone', NULL), (11, 'default2', 1), (12, NULL, 1), (13, 'default1', NULL), (14, NULL, 1), (15, 'default1', 2), (16, NULL, 1), (17, NULL, 2), (18, NULL, NULL), (19, 'default1', 2), (20, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 2, -1, '2023-01-01', NULL, 2), (-1, 1, 2, '2023-01-01', 2, 2), (9, -1, -1, '2023-01-02', 1, NULL), (20, 2, NULL, '2023-01-02', 2, NULL), (5, -1, -1, NULL, NULL, 2), (1, -1, 0, '2023-01-01', NULL, NULL), (3, 2, 2, '2023-01-02', 1, 2), (NULL, 2, -1, '2023-01-02', NULL, NULL), (13, NULL, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) AND BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8'));

/*
Prediction Result:
*/