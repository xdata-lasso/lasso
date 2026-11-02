-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 1), (1, 'S8', 2), (-1, 'default1', NULL), (0, 'S8', NULL), (3, NULL, NULL), (4, NULL, 2), (5, 'default1', 2), (6, 'iPhone', NULL), (7, 'S8', NULL), (8, 'default1', 1), (9, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, NULL, '2023-01-01', 1, 1), (8, NULL, 0, '2023-01-01', NULL, 1), (4, -1, 0, NULL, NULL, 1), (4, 2, NULL, '2023-01-01', 1, NULL), (1, 2, NULL, '2023-01-02', 1, NULL), (8, NULL, -1, '2023-01-02', NULL, NULL), (5, -1, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8' AND NOT A.BUYER_ID IN (SELECT BUYER_ID FROM SALES AS X LEFT JOIN PRODUCT AS Y ON X.PRODUCT_ID = Y.PRODUCT_ID WHERE Y.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(None,)
*/