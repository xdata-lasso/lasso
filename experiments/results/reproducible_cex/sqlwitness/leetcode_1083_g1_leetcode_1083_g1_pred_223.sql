-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (2, NULL, NULL), (0, 'S8', 2), (-1, NULL, 2), (3, 'default2', 1), (4, 'default2', NULL), (5, NULL, 2), (6, NULL, 1), (7, 'iPhone', 1), (8, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 0, NULL, 1, 1), (5, 1, 2, NULL, 2, 1), (5, NULL, 0, '2023-01-01', 2, NULL), (8, 0, NULL, '2023-01-02', NULL, 2), (1, -1, -1, '2023-01-02', 2, NULL), (4, -1, 2, '2023-01-02', 2, NULL), (1, 1, 2, '2023-01-01', 1, NULL), (4, NULL, 0, '2023-01-02', 1, NULL), (-1, 1, 0, '2023-01-02', 1, 2), (6, 2, -1, NULL, 2, 2), (7, 1, 0, NULL, 2, 2), (NULL, NULL, 2, '2023-01-01', 2, 2), (6, 1, 1, '2023-01-02', 2, 1), (-1, -1, NULL, '2023-01-01', 1, 2), (0, 0, 1, '2023-01-01', 2, 2), (7, -1, NULL, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(1,)
(2,)
*/

-- Prediction Query
WITH IPHONEBUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'iPhone'), S8BUYERS AS (SELECT BUYER_ID FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND B.PRODUCT_NAME = 'S8') SELECT DISTINCT A.BUYER_ID FROM SALES AS A CROSS JOIN S8BUYERS AS I WHERE A.BUYER_ID = I.BUYER_ID AND NOT A.BUYER_ID IN (SELECT BUYER_ID FROM IPHONEBUYERS);

/*
Prediction Result:
*/