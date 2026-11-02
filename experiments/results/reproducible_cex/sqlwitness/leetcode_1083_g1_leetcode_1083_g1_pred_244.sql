-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, 'iPhone', NULL), (-1, 'S8', 2), (2, 'S8', 2), (3, 'default1', NULL), (4, 'S8', NULL), (5, 'S8', NULL), (6, 'default1', 2), (7, NULL, 1), (8, 'iPhone', 2), (9, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 0, NULL, '2023-01-01', NULL, NULL), (7, 2, 1, NULL, 2, 1), (4, -1, 1, NULL, 2, NULL), (7, NULL, NULL, NULL, NULL, 1), (8, 1, 2, '2023-01-02', NULL, 1), (5, -1, 2, '2023-01-01', NULL, NULL), (4, NULL, -1, '2023-01-02', NULL, 2), (-1, 2, NULL, '2023-01-01', 1, NULL), (5, 0, NULL, '2023-01-02', NULL, NULL), (-1, 2, -1, NULL, NULL, NULL), (1, 1, 1, '2023-01-02', 1, NULL), (4, -1, 2, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
WITH TEMP AS (SELECT S.*, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM TEMP WHERE BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/