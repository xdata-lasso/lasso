-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'default2', 2), (2, 'iPhone', 1), (-1, 'iPhone', NULL), (3, 'iPhone', NULL), (4, NULL, NULL), (5, 'S8', 2), (6, 'iPhone', 1), (7, 'default2', 2), (8, 'default1', 1), (9, 'S8', NULL), (10, NULL, 2), (11, NULL, NULL), (12, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 2, '2023-01-01', 1, 2), (4, -1, 1, NULL, 2, 1), (9, -1, -1, '2023-01-02', 2, NULL), (0, 0, 2, '2023-01-01', 1, 1), (10, NULL, NULL, NULL, 2, 1), (3, 1, 1, '2023-01-01', 2, 2), (8, NULL, 0, '2023-01-01', 2, 2), (10, NULL, 2, '2023-01-01', NULL, 2), (7, 1, 1, '2023-01-02', 2, 1), (9, -1, NULL, NULL, 2, 2), (1, 2, 1, NULL, 2, 1), (11, -1, NULL, '2023-01-02', 1, 2), (2, 2, 1, '2023-01-02', 1, 1), (6, 0, 0, NULL, 2, 2), (8, 1, 0, '2023-01-02', NULL, NULL), (8, 1, -1, '2023-01-01', NULL, NULL), (1, -1, NULL, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS SLS JOIN PRODUCT AS PRD ON SLS.PRODUCT_ID = PRD.PRODUCT_ID GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') >= 1 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(-1,)
*/