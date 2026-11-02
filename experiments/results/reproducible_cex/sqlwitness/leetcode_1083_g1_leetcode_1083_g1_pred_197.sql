-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', NULL), (0, 'default1', 1), (2, 'iPhone', NULL), (1, 'S8', 2), (3, 'S8', 1), (4, 'default1', 1), (5, 'iPhone', 1), (6, NULL, 1), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 0, '2023-01-01', 1, NULL), (NULL, -1, -1, NULL, 2, NULL), (3, 0, NULL, NULL, 1, 2), (1, 2, NULL, '2023-01-02', 2, 2), (7, 1, NULL, '2023-01-02', 2, NULL), (NULL, -1, 1, NULL, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
*/

-- Prediction Query
WITH S8BUYERS AS (SELECT DISTINCT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), IPHONEBUYERS AS (SELECT DISTINCT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT * FROM S8BUYERS WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM IPHONEBUYERS);

/*
Prediction Result:
(None,)
*/