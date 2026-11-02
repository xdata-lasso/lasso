-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2), (0, 'default2', NULL), (1, 'S8', 1), (-1, 'default1', NULL), (3, 'default1', 1), (4, NULL, 2), (5, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 2, NULL, 1, 1), (NULL, -1, 2, NULL, 1, 2), (0, NULL, 2, NULL, 1, 2), (3, 0, -1, '2023-01-01', 1, 1), (5, 2, NULL, '2023-01-01', 2, 1), (2, -1, 1, '2023-01-01', 1, 2), (NULL, NULL, 0, '2023-01-02', 1, 2), (0, 0, 0, '2023-01-02', 2, 1), (NULL, 0, 0, '2023-01-01', 2, NULL), (0, NULL, -1, '2023-01-02', NULL, 1), (3, NULL, 1, '2023-01-02', NULL, 2), (-1, NULL, 0, '2023-01-01', 2, 2), (NULL, 2, -1, '2023-01-01', 2, NULL), (4, 0, 0, '2023-01-02', 2, 2), (2, 1, 1, '2023-01-02', 1, NULL), (1, NULL, -1, '2023-01-02', 1, NULL), (5, 2, NULL, '2023-01-02', NULL, 1), (5, 0, 1, '2023-01-02', NULL, 1), (2, NULL, -1, '2023-01-02', 1, 1), (4, 2, 2, '2023-01-01', 2, 2), (5, NULL, NULL, NULL, NULL, 2), (1, 0, 1, NULL, 2, NULL), (2, NULL, NULL, NULL, NULL, 2), (1, 1, NULL, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
*/

-- Prediction Query
WITH PRODUCTS_BOUGHT AS (SELECT BUYER_ID, CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END AS S8, CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END AS IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID), BUYER_SUMMARY AS (SELECT BUYER_ID, SUM(S8) AS S8, SUM(IPHONE) AS IPHONE FROM PRODUCTS_BOUGHT GROUP BY 1) SELECT BUYER_ID FROM BUYER_SUMMARY WHERE S8 >= 1 AND IPHONE = 0;

/*
Prediction Result:
(None,)
(-1,)
(1,)
*/