-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 1), (-1, 'default2', 2), (2, 'default2', 1), (0, 'S8', NULL), (3, 'default1', 2), (4, 'iPhone', NULL), (5, 'iPhone', 2), (6, 'default2', NULL), (7, 'default2', 1), (8, NULL, NULL), (9, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 0, '2023-01-01', 2, NULL), (8, 0, -1, '2023-01-02', NULL, NULL), (3, 1, -1, NULL, 2, NULL), (2, 2, -1, '2023-01-02', NULL, 1), (6, 2, NULL, '2023-01-01', 2, 1), (6, 0, NULL, '2023-01-01', NULL, 2), (4, NULL, -1, NULL, NULL, NULL), (NULL, 2, 0, NULL, 2, 1), (6, NULL, -1, '2023-01-01', 2, 2), (-1, 0, 0, NULL, 2, 1), (-1, 1, -1, NULL, 1, NULL), (2, -1, 1, '2023-01-01', 1, 1), (-1, -1, 1, '2023-01-01', 2, 1), (0, 1, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/