-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (2, 'default1', 2), (0, 'default2', 1), (1, NULL, 1), (3, 'default1', NULL), (4, 'default1', 1), (5, 'default1', NULL), (6, 'S8', NULL), (7, 'default2', 1), (8, 'S8', NULL), (9, 'default1', 2), (10, 'default2', 2), (11, 'default2', NULL), (12, 'default2', 1), (13, 'S8', 1), (14, 'iPhone', 2), (15, 'default2', 2), (16, 'default1', 1), (17, 'iPhone', 1), (18, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 2, NULL, NULL, 2), (9, 0, 2, NULL, 2, NULL), (12, 0, NULL, '2023-01-01', 1, 1), (17, 1, 2, '2023-01-01', 1, NULL), (2, -1, 1, '2023-01-02', 2, NULL), (6, 0, 0, '2023-01-01', NULL, 2), (14, -1, NULL, NULL, 2, 2), (11, 2, 1, '2023-01-01', 2, NULL), (18, -1, 1, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH IP AS (SELECT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT * FROM IP) GROUP BY 1;

/*
Prediction Result:
*/