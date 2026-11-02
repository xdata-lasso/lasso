-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', NULL), (0, NULL, NULL), (2, 'iPhone', 2), (1, 'S8', NULL), (3, 'S8', 1), (4, 'default2', 2), (5, 'iPhone', NULL), (6, 'default2', NULL), (7, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, -1, NULL, NULL, NULL, 2), (5, 2, NULL, '2023-01-01', 2, 2), (4, 1, 1, NULL, NULL, NULL), (3, 0, -1, '2023-01-01', 1, 2), (-1, NULL, -1, '2023-01-01', 2, 2), (NULL, NULL, 1, '2023-01-01', 1, 1), (7, 0, 2, '2023-01-02', NULL, 2), (3, -1, 0, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH IPHONE_BUYERS AS (SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone'), S8_BUYERS AS (SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') SELECT * FROM S8_BUYERS WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM IPHONE_BUYERS);

/*
Prediction Result:
*/