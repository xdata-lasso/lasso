-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 2), (-1, 'S8', 1), (1, 'default2', 1), (2, NULL, 1), (3, 'iPhone', 1), (4, 'iPhone', 2), (5, 'default2', 1), (6, 'iPhone', 1), (7, 'default2', 1), (8, 'S8', NULL), (9, NULL, 1), (10, 'S8', NULL), (11, 'iPhone', NULL), (12, 'default1', NULL), (13, 'S8', 1), (14, 'default1', 1), (15, 'default2', 1), (16, 'iPhone', 1), (17, 'default1', 2), (18, NULL, 1), (19, 'default2', NULL), (20, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (16, 2, NULL, NULL, 1, 2), (5, 1, 1, '2023-01-01', 2, 1), (6, 1, -1, '2023-01-02', 1, NULL), (15, 1, 0, '2023-01-02', 1, 1), (0, 1, 1, '2023-01-02', 2, 2), (13, 2, 2, NULL, 1, NULL), (11, 0, 0, NULL, 2, 2), (NULL, 0, 0, NULL, 1, 1), (4, 0, NULL, '2023-01-02', 2, 1), (7, 1, NULL, '2023-01-01', 1, NULL), (13, 1, 0, NULL, 1, 1), (3, 2, -1, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH X AS (SELECT * FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID)) SELECT DISTINCT BUYER_ID FROM X WHERE PRODUCT_NAME IN ('S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM X WHERE PRODUCT_NAME IN ('iPhone'));

/*
Prediction Result:
*/