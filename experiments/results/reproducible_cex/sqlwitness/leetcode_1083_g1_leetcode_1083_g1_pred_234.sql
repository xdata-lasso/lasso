-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 2), (1, 'S8', 2), (2, 'default1', 1), (0, 'S8', 1), (3, 'iPhone', 2), (4, NULL, NULL), (5, 'S8', 2), (6, 'iPhone', 1), (7, 'iPhone', 1), (8, 'S8', 2), (9, 'S8', 2), (10, 'default2', 2), (11, 'S8', 1), (12, 'iPhone', 2), (13, 'default2', NULL), (14, 'iPhone', 1), (15, 'default2', NULL), (16, NULL, 2), (17, 'default1', 1), (18, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (17, 1, 2, '2023-01-01', 2, 2), (6, 0, NULL, NULL, NULL, NULL), (5, 1, 0, '2023-01-01', 2, 2), (4, 0, -1, '2023-01-01', NULL, 2), (16, 2, -1, NULL, 2, NULL), (17, -1, NULL, '2023-01-02', 1, 2), (15, NULL, -1, '2023-01-01', 2, 2), (3, -1, 1, NULL, NULL, NULL), (4, -1, 1, NULL, 2, 2), (18, 1, 0, '2023-01-01', NULL, NULL), (2, 0, 0, '2023-01-02', 1, 1), (12, -1, 1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH SALES_WITH_PRODUCT_NAME AS (SELECT S.BUYER_ID, S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT (BUYER_ID) FROM SALES_WITH_PRODUCT_NAME WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT_NAME WHERE PRODUCT_NAME = 'iPhone') AND BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT_NAME WHERE PRODUCT_NAME = 'S8');

/*
Prediction Result:
*/