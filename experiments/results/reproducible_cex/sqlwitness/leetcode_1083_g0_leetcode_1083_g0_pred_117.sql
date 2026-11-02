-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 1), (1, NULL, NULL), (0, 'default2', 2), (2, NULL, 1), (3, 'default2', 1), (4, 'default1', 2), (5, NULL, 2), (6, 'default2', NULL), (7, 'iPhone', 1), (8, NULL, NULL), (9, 'S8', NULL), (10, 'iPhone', 2), (11, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, -1, '2023-01-02', 2, 2), (4, -1, 1, '2023-01-01', 1, NULL), (7, -1, NULL, '2023-01-01', 2, 2), (6, -1, 1, NULL, 2, NULL), (0, NULL, 1, '2023-01-02', 2, 1), (4, -1, 1, '2023-01-01', 2, NULL), (4, 0, -1, '2023-01-01', NULL, 2), (6, -1, 1, '2023-01-01', 2, NULL), (7, 1, 0, '2023-01-02', NULL, NULL), (10, NULL, 2, '2023-01-02', 2, 1), (9, 2, 1, '2023-01-02', 2, 1), (0, 1, 2, NULL, NULL, NULL), (8, 0, -1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID) GROUP BY BUYER_ID HAVING SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(1,)
*/