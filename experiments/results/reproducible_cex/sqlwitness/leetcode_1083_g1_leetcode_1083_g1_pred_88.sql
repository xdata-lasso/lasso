-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, 'S8', 1), (-1, 'default2', NULL), (2, 'default2', NULL), (3, 'S8', NULL), (4, 'default1', 2), (5, 'default1', 1), (6, 'default1', 2), (7, 'default1', NULL), (8, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, NULL, '2023-01-02', 1, NULL), (8, 0, 0, '2023-01-02', NULL, 2), (7, 1, 1, '2023-01-02', 2, 1), (4, -1, 1, '2023-01-02', 1, NULL), (8, NULL, NULL, NULL, 2, 1), (NULL, 1, 1, '2023-01-01', NULL, NULL), (7, -1, -1, '2023-01-02', 2, NULL), (5, NULL, 2, NULL, NULL, NULL), (1, -1, NULL, NULL, 1, NULL), (8, NULL, NULL, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH A AS (SELECT A.BUYER_ID, MAX(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS BOUGHT_S8, MAX(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS BOUGHT_IPHONE FROM SALES AS A INNER JOIN PRODUCT AS B ON B.PRODUCT_ID = A.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM A WHERE BOUGHT_S8 = 1 AND BOUGHT_IPHONE = 0;

/*
Prediction Result:
(None,)
(0,)
*/