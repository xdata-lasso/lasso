-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 2), (-1, NULL, 2), (0, 'default1', NULL), (1, 'S8', NULL), (3, 'iPhone', 1), (4, 'iPhone', NULL), (5, 'S8', NULL), (6, 'iPhone', 1), (7, 'default2', 1), (8, 'S8', NULL), (9, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 2, 2, NULL, 1, 2), (4, 2, 0, NULL, NULL, 1), (8, -1, -1, NULL, 2, 1), (9, -1, 2, '2023-01-01', 1, NULL), (9, 2, -1, '2023-01-02', NULL, NULL), (-1, 1, 2, '2023-01-02', 1, 2), (9, 1, 2, '2023-01-02', 1, NULL), (7, -1, 0, NULL, 2, NULL), (6, 1, NULL, '2023-01-01', 1, 1), (1, NULL, 1, NULL, 1, NULL), (-1, 2, -1, NULL, 2, 2);
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
WITH TT AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' OR P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM TT WHERE NOT TT.BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM TT WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/