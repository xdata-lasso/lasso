-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (0, 'default2', 1), (1, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, NULL, NULL, 2, 2), (1, 1, NULL, '2023-01-01', 1, 1), (-1, -1, 2, '2023-01-02', NULL, 2), (0, NULL, NULL, NULL, NULL, 1), (1, 1, 0, '2023-01-02', 1, 2), (1, 2, 1, '2023-01-02', 1, NULL), (NULL, -1, 2, NULL, NULL, 2);
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
WITH CTE AS (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT C1.BUYER_ID FROM CTE AS C1 LEFT JOIN (SELECT BUYER_ID FROM CTE WHERE PRODUCT_NAME = 'iPhone') AS C2 ON C1.BUYER_ID = C2.BUYER_ID WHERE C1.PRODUCT_NAME = 'S8' AND C2.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/