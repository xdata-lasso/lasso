-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', NULL), (1, 'default1', 1), (2, 'default1', 1), (0, 'S8', 1), (3, 'default1', 1), (4, 'S8', 2), (5, 'S8', 1), (6, 'iPhone', 2), (7, 'S8', 1), (8, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 2, 0, NULL, NULL, 1), (6, NULL, NULL, '2023-01-01', NULL, 1), (7, 0, NULL, '2023-01-02', 2, NULL), (0, NULL, 1, '2023-01-01', 1, 2), (3, 1, 0, '2023-01-02', 2, 1), (6, 0, -1, '2023-01-01', 1, NULL), (0, NULL, 0, '2023-01-02', 2, NULL), (4, -1, 0, '2023-01-02', NULL, NULL), (7, NULL, 2, NULL, 2, NULL), (-1, 1, 2, '2023-01-02', 1, NULL), (8, NULL, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
WITH T0 AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID) SELECT BUYER_ID FROM T0 GROUP BY BUYER_ID HAVING (BUYER_ID, 'S8') IN (SELECT * FROM T0) AND NOT (BUYER_ID, 'iPhone') IN (SELECT * FROM T0);

/*
Prediction Result:
*/