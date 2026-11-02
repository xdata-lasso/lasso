-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', NULL), (0, NULL, NULL), (1, 'iPhone', 1), (-1, 'default2', 2), (3, NULL, NULL), (4, 'default1', 2), (5, 'default2', 2), (6, 'S8', 1), (7, 'iPhone', NULL), (8, 'default2', 1), (9, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 2, NULL, 1, NULL), (6, 0, NULL, '2023-01-01', NULL, NULL), (8, 0, 1, '2023-01-02', 1, 2), (6, 0, 2, '2023-01-02', 1, 1), (2, 0, 2, NULL, 1, NULL), (1, 2, 1, '2023-01-02', 2, 1), (7, NULL, 2, '2023-01-02', NULL, 2), (0, 0, 2, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/