-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 2), (1, 'iPhone', NULL), (-1, 'default2', 2), (2, 'S8', 2), (3, 'default1', 2), (4, 'default1', 2), (5, 'default1', NULL), (6, 'default1', 2), (7, 'default2', 2), (8, 'S8', 1), (9, 'default1', 1), (10, 'default2', NULL), (11, NULL, 2), (12, 'iPhone', NULL), (13, 'iPhone', 2), (14, 'default2', 2), (15, 'default2', NULL), (16, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, NULL, '2023-01-02', 2, 2), (13, 2, NULL, '2023-01-02', 1, NULL), (2, 2, -1, '2023-01-02', 2, 1), (0, 0, 1, '2023-01-01', 2, 1), (14, 0, 1, '2023-01-01', NULL, 2), (5, 0, 2, '2023-01-02', NULL, 1), (3, -1, 0, NULL, NULL, 1), (4, 0, NULL, '2023-01-02', 2, 1), (6, 0, -1, '2023-01-02', 1, NULL), (0, NULL, 2, '2023-01-02', 1, NULL), (0, 2, NULL, NULL, NULL, NULL), (9, -1, 2, '2023-01-02', NULL, 2), (3, 2, 2, '2023-01-01', 2, 1), (10, -1, 0, NULL, 1, 2), (-1, NULL, 1, '2023-01-02', NULL, 2), (12, 2, -1, NULL, NULL, 1), (4, NULL, 0, '2023-01-02', NULL, 1), (7, NULL, 1, '2023-01-02', 2, 1), (7, -1, NULL, '2023-01-02', NULL, 2), (9, 1, -1, '2023-01-01', NULL, 2), (2, NULL, 2, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH SALES_WITH_PRODUCT AS (SELECT A.BUYER_ID, A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT WHERE PRODUCT_NAME = 'iPhone') GROUP BY BUYER_ID;

/*
Prediction Result:
*/