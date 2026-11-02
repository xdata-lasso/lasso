-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 1), (0, '%S8%', 1), (-1, NULL, 1), (1, 'default2', 1), (3, 'default1', 1), (4, 'default2', NULL), (5, '%IPHONE%', 2), (6, 'default1', 1), (7, 'default1', NULL), (8, '%S8%', 2), (9, NULL, 2), (10, 'iPhone', NULL), (11, 'iPhone', NULL), (12, '%S8%', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, NULL, NULL, NULL), (1, -1, -1, '2023-01-02', NULL, 2), (6, NULL, NULL, '2023-01-01', 1, NULL), (6, 0, 1, '2023-01-02', NULL, NULL), (5, 1, NULL, NULL, 2, 2), (NULL, 0, 0, NULL, NULL, NULL), (10, -1, 1, NULL, 2, 2), (12, 1, 0, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING GROUP_CONCAT(DISTINCT PRODUCT_NAME) LIKE '%S8%' AND GROUP_CONCAT(DISTINCT PRODUCT_NAME) NOT LIKE '%IPHONE%';

/*
Prediction Result:
(0,)
*/