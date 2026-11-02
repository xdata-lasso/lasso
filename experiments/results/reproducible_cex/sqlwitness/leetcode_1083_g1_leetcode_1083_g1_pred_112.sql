-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (2, 'default2', 1), (1, 'iPhone', 2), (-1, 'S8', 2), (3, 'default2', NULL), (4, 'S8', 1), (5, 'default2', 2), (6, 'S8', NULL), (7, 'iPhone', 2), (8, 'default2', NULL), (9, NULL, 1), (10, NULL, NULL), (11, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, -1, '2023-01-01', 1, 2), (NULL, 0, 0, '2023-01-01', 1, 2), (4, -1, NULL, '2023-01-02', 1, NULL), (5, 2, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING SUM(B.PRODUCT_NAME = 'S8') > 0 AND SUM(B.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/