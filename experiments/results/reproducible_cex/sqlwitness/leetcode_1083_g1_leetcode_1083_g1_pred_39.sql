-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (-1, NULL, 1), (2, 'S8', NULL), (1, NULL, 1), (3, 'iPhone', 2), (4, 'S8', NULL), (5, NULL, NULL), (6, 'default1', 2), (7, 'iPhone', NULL), (8, 'default1', 2), (9, 'default1', NULL), (10, 'iPhone', 2), (11, NULL, 2), (12, NULL, NULL), (13, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, 2, '2023-01-02', 2, 2), (0, 2, -1, '2023-01-01', 1, 2), (12, 1, -1, NULL, 1, 2), (6, NULL, 0, '2023-01-01', 2, NULL), (3, NULL, NULL, '2023-01-02', 1, 2), (9, -1, 0, NULL, 2, NULL), (0, -1, -1, NULL, 2, NULL), (4, 0, -1, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT DISTINCT (BUYER_ID) FROM SALES WHERE BUYER_ID IN (SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/