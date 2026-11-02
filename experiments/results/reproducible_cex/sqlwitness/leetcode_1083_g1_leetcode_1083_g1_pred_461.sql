-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'S8', NULL), (2, 'default1', 1), (-1, 'iPhone', 1), (3, 'default2', NULL), (4, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, -1, NULL, 1, 1), (-1, 2, 2, '2023-01-02', 1, 1), (3, -1, 1, '2023-01-01', 1, NULL), (0, 2, NULL, NULL, NULL, 2), (NULL, 0, NULL, '2023-01-01', NULL, NULL), (0, -1, NULL, '2023-01-01', 1, NULL), (4, 0, 0, NULL, NULL, 2), (3, 1, -1, '2023-01-02', 2, 2), (2, NULL, 1, '2023-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(0,)
*/

-- Prediction Query
WITH C1 AS (SELECT S.*, P.PRODUCT_NAME, P.UNIT_PRICE FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM C1 GROUP BY BUYER_ID) AS Q WHERE S8 >= 1 AND IPHONE = 0;

/*
Prediction Result:
(None,)
(-1,)
(0,)
*/