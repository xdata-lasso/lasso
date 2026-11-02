-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, 'default2', 2), (-1, 'S8', 1), (2, 'default2', 1), (3, 'S8', NULL), (4, 'default2', 2), (5, 'S8', 1), (6, 'iPhone', 2), (7, 'iPhone', 1), (8, 'default1', NULL), (9, NULL, 2), (10, 'S8', 1), (11, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, -1, NULL, '2023-01-02', 1, 1), (3, 0, NULL, '2023-01-02', 2, 2), (0, 2, 1, '2023-01-01', NULL, 2), (0, -1, 1, NULL, 1, 2), (3, 2, 0, NULL, 1, 2), (11, 0, NULL, '2023-01-02', NULL, 1), (1, NULL, NULL, '2023-01-02', NULL, 1), (NULL, 2, 2, '2023-01-02', 1, NULL), (0, 2, NULL, '2023-01-02', NULL, 1), (10, -1, 1, '2023-01-02', 1, 2), (11, NULL, NULL, '2023-01-02', 1, 2), (0, 2, NULL, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING COUNT(CASE PRODUCT_NAME WHEN 'S8' THEN 1 ELSE NULL END) >= 1 AND COUNT(CASE PRODUCT_NAME WHEN 'iPhone' THEN 1 ELSE NULL END) = 0;

/*
Prediction Result:
(0,)
(1,)
*/