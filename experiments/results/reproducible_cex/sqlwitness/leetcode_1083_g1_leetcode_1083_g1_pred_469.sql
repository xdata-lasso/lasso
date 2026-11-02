-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (-1, 'default2', NULL), (1, 'default2', 1), (2, 'default2', 1), (3, 'S8', 1), (4, 'default2', 1), (5, 'default2', 2), (6, 'iPhone', 2), (7, 'default2', 1), (8, 'S8', 1), (9, 'iPhone', 2), (10, 'iPhone', 1), (11, 'S8', 2), (12, NULL, NULL), (13, 'iPhone', 1), (14, 'iPhone', NULL), (15, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, -1, 2, NULL, 1, NULL), (4, NULL, 2, '2023-01-02', 2, NULL), (10, -1, 0, NULL, NULL, 2), (4, 2, 0, '2023-01-01', 2, 2), (6, NULL, NULL, NULL, 2, 2), (6, 0, 1, '2023-01-02', 1, 2), (11, 0, 1, NULL, 2, 2), (15, 1, NULL, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH CTE AS (SELECT SALES.BUYER_ID, PRODUCT.* FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/