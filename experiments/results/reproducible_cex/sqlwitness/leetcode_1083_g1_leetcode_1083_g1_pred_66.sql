-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 2), (2, NULL, 1), (-1, NULL, NULL), (1, 'iPhone', 2), (3, NULL, 1), (4, 'default1', NULL), (5, 'default1', 1), (6, 'S8', 1), (7, 'iPhone', 1), (8, 'default1', 2), (9, 'default2', 2), (10, 'default2', 2), (11, 'default2', 1), (12, 'S8', 2), (13, 'S8', 2), (14, 'iPhone', NULL), (15, 'default1', 2), (16, 'iPhone', 1), (17, 'S8', 1), (18, 'default2', NULL), (19, 'default1', NULL), (20, 'default2', NULL), (21, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (18, 2, 0, NULL, 2, NULL), (17, NULL, NULL, '2023-01-02', 2, 1), (1, 1, 1, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/