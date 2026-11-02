-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 2), (1, 'default1', 2), (-1, NULL, NULL), (0, 'default2', NULL), (3, 'S8', NULL), (4, 'S8', 2), (5, 'default2', 1), (6, 'iPhone', 1), (7, 'default2', 1), (8, 'default2', 1), (9, 'default2', NULL), (10, NULL, 1), (11, 'iPhone', 1), (12, 'default2', NULL), (13, 'iPhone', 2), (14, 'S8', NULL), (15, NULL, 2), (16, 'S8', 2), (17, 'S8', 1), (18, NULL, NULL), (19, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, 2, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID AND P1.PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES AS S1 JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID AND P1.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/