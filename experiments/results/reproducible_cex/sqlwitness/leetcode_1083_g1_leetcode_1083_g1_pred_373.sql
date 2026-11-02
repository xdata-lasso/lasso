-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 2), (-1, 'S8', NULL), (2, 'default1', NULL), (0, 'default1', NULL), (3, 'default2', 2), (4, 'S8', NULL), (5, 'iPhone', NULL), (6, 'iPhone', 1), (7, 'default2', 1), (8, 'default1', 2), (9, NULL, 1), (10, NULL, NULL), (11, 'iPhone', NULL), (12, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 2, NULL, '2023-01-02', 2, NULL), (4, -1, 2, '2023-01-02', NULL, 1), (0, -1, -1, '2023-01-02', NULL, 2), (2, -1, NULL, '2023-01-01', 1, 2), (NULL, -1, NULL, '2023-01-01', 1, NULL), (12, 0, 1, '2023-01-01', 2, NULL), (5, -1, NULL, NULL, NULL, NULL), (4, 2, -1, '2023-01-01', 2, NULL), (8, NULL, 1, NULL, 2, 1), (10, 0, 0, '2023-01-02', 1, 1), (NULL, -1, 2, '2023-01-02', 2, NULL), (2, 0, -1, '2023-01-02', 1, NULL), (12, -1, NULL, '2023-01-01', NULL, NULL), (2, 1, NULL, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(-1,)
(2,)
*/

-- Prediction Query
WITH TEMP AS (SELECT SELLER_ID, BUYER_ID, SALE_DATE, QUANTITY, PRICE, PRDT.PRODUCT_NAME AS PRODUCT_NAME FROM SALES AS SALES LEFT JOIN PRODUCT AS PRDT ON SALES.PRODUCT_ID = PRDT.PRODUCT_ID) SELECT DISTINCT BUYER_ID FROM TEMP WHERE BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('S8')) AND NOT BUYER_ID IN (SELECT BUYER_ID FROM TEMP WHERE PRODUCT_NAME IN ('iPhone'));

/*
Prediction Result:
*/