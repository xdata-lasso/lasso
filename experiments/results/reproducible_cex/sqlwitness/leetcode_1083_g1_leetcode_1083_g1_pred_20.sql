-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (-1, NULL, 1), (1, 'S8', NULL), (2, 'iPhone', NULL), (3, 'default1', 1), (4, 'iPhone', NULL), (5, 'default1', NULL), (6, 'default2', 2), (7, 'iPhone', NULL), (8, 'S8', 2), (9, 'iPhone', 2), (10, 'default2', NULL), (11, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, NULL, '2023-01-01', 2, NULL), (8, 1, -1, '2023-01-01', 1, 1), (3, 1, -1, '2023-01-01', NULL, 1), (6, 1, 1, '2023-01-02', 2, 1), (11, 1, 2, '2023-01-01', NULL, NULL), (1, 1, NULL, NULL, 1, 2), (-1, 0, -1, '2023-01-02', NULL, NULL), (NULL, 2, 2, '2023-01-01', NULL, 2), (4, NULL, NULL, '2023-01-01', NULL, NULL), (NULL, 1, 1, '2023-01-01', 2, 2), (NULL, 2, NULL, NULL, 1, NULL), (6, NULL, 1, '2023-01-01', NULL, 1), (10, 0, -1, '2023-01-02', 2, NULL), (1, 2, 0, '2023-01-02', 2, 2), (2, NULL, NULL, '2023-01-02', 2, 2), (1, 1, -1, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8' AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone' GROUP BY BUYER_ID);

/*
Prediction Result:
*/