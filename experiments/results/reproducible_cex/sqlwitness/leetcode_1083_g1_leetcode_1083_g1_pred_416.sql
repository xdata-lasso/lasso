-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2), (1, 'default1', 1), (-1, NULL, NULL), (0, 'S8', NULL), (3, 'default1', 1), (4, 'default1', NULL), (5, 'S8', NULL), (6, NULL, NULL), (7, 'iPhone', 1), (8, 'default2', NULL), (9, 'S8', 1), (10, 'S8', 1), (11, NULL, 1), (12, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, -1, 0, '2023-01-02', NULL, 1), (10, NULL, 1, '2023-01-01', 2, 2), (3, 2, NULL, '2023-01-01', 2, NULL), (2, -1, NULL, '2023-01-02', 2, 2), (0, NULL, 0, NULL, 1, 1), (NULL, 2, NULL, NULL, 1, 2), (-1, 0, 1, '2023-01-01', NULL, NULL), (2, NULL, -1, NULL, 1, 1), (11, NULL, 2, NULL, 1, NULL), (9, 0, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/