-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 2), (-1, 'default2', 2), (0, 'S8', 2), (1, NULL, 1), (3, 'default2', 1), (4, 'default1', 2), (5, 'iPhone', NULL), (6, 'iPhone', 1), (7, NULL, NULL), (8, 'iPhone', 1), (9, 'default1', 1), (10, 'default1', 1), (11, 'S8', 2), (12, 'S8', 1), (13, 'default2', NULL), (14, 'default1', NULL), (15, 'default2', 1), (16, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, 1, 0, '2023-01-01', 2, NULL), (10, 2, NULL, '2023-01-01', NULL, 1), (2, -1, 0, '2023-01-02', NULL, NULL), (7, 2, 2, NULL, 1, 1), (15, 0, NULL, '2023-01-01', NULL, NULL), (4, 1, 2, '2023-01-01', 1, NULL), (15, 1, NULL, NULL, 1, NULL), (12, NULL, -1, NULL, 1, 2), (NULL, 2, 0, NULL, NULL, 2), (5, 0, 1, '2023-01-02', 2, NULL), (6, 0, NULL, NULL, 2, NULL), (7, -1, 0, '2023-01-02', 2, 2), (13, -1, NULL, '2023-01-02', 2, 1), (1, 1, 2, NULL, NULL, NULL), (1, 0, 0, '2023-01-02', NULL, NULL), (4, 1, 2, '2023-01-01', NULL, 2), (16, 1, 2, '2023-01-02', 1, 2), (15, 1, 2, NULL, 2, 1), (2, 1, 0, '2023-01-01', NULL, NULL), (14, NULL, -1, '2023-01-01', 1, 1), (0, 2, -1, '2023-01-02', 2, 1), (15, 0, -1, '2023-01-01', 1, 1), (2, 1, 1, NULL, NULL, 2), (12, 0, NULL, '2023-01-01', 1, 2), (NULL, -1, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH COMB AS (SELECT P.PRODUCT_ID AS PID, P.PRODUCT_NAME AS NAME, S.BUYER_ID AS BID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT (BID) AS BUYER_ID FROM COMB WHERE BID IN (SELECT BID FROM COMB WHERE NAME = 'S8') AND NOT BID IN (SELECT BID FROM COMB WHERE NAME = 'iPhone');

/*
Prediction Result:
*/