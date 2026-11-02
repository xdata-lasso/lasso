-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (2, 'default2', NULL), (1, NULL, 1), (-1, NULL, NULL), (3, 'iPhone', NULL), (4, NULL, NULL), (5, 'S8', 2), (6, 'S8', 1), (7, 'default1', 2), (8, 'iPhone', NULL), (9, 'default1', NULL), (10, 'default2', 2), (11, 'S8', NULL), (12, 'default2', 2), (13, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 0, NULL, 2, 1), (7, 0, 2, NULL, 2, NULL), (7, 0, 2, '2023-01-01', 1, 1), (8, -1, 1, '2023-01-01', 2, 2), (12, NULL, 1, NULL, 2, 2), (2, -1, NULL, '2023-01-02', 1, NULL), (-1, 0, 0, '2023-01-01', 2, NULL), (5, NULL, NULL, '2023-01-01', 1, NULL), (10, 0, NULL, NULL, 2, 1), (10, 1, 0, '2023-01-02', 2, 1), (12, NULL, NULL, '2023-01-01', NULL, 2), (11, 2, 2, NULL, 1, NULL), (3, -1, 0, NULL, 1, NULL), (0, 2, 0, NULL, 1, 1), (3, 0, -1, NULL, 2, 1), (13, 0, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') < 1;

/*
Prediction Result:
(None,)
(2,)
*/