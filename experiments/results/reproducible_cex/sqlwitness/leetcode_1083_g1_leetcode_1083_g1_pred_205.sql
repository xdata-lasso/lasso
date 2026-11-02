-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (0, 'default2', 1), (2, 'S8', 1), (-1, 'iPhone', NULL), (3, 'S8', NULL), (4, NULL, NULL), (5, 'S8', 2), (6, 'S8', NULL), (7, 'default2', 1), (8, 'iPhone', 1), (9, 'default2', 1), (10, 'default1', 2), (11, 'default2', 2), (12, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 0, 0, '2023-01-02', 2, NULL), (10, NULL, -1, '2023-01-01', 2, 1), (3, 1, NULL, NULL, NULL, NULL), (7, 1, NULL, '2023-01-02', 1, NULL), (1, 1, 0, '2023-01-01', 2, 1), (5, 1, -1, '2023-01-01', 1, NULL), (3, 0, -1, NULL, 1, 2), (9, 1, 2, NULL, 1, 1), (10, NULL, 2, NULL, 2, 1), (4, 2, -1, '2023-01-02', 1, 2), (4, 0, 1, '2023-01-02', 2, NULL), (12, 2, -1, NULL, 1, 2), (1, 2, NULL, '2023-01-02', 2, 2), (6, 2, 0, '2023-01-01', 2, NULL), (0, 0, 0, '2023-01-02', 1, 2), (4, NULL, 2, NULL, 2, 2), (7, -1, NULL, NULL, 2, NULL), (0, 1, NULL, '2023-01-01', 2, 1), (7, -1, -1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH CTE AS (SELECT A.SELLER_ID, A.PRODUCT_ID, B.PRODUCT_NAME, B.UNIT_PRICE, A.BUYER_ID, A.SALE_DATE, A.QUANTITY, A.PRICE FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM CTE WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/