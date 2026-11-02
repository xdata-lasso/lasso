-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, NULL, 2), (2, NULL, 1), (-1, NULL, 2), (3, 'iPhone', NULL), (4, 'default2', 1), (5, NULL, 1), (6, 'default2', 2), (7, 'default1', 1), (8, 'S8', 1), (9, 'iPhone', 2), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, -1, NULL, '2023-01-02', 2, 1), (1, NULL, NULL, '2023-01-01', NULL, 2), (6, 1, NULL, NULL, 2, NULL), (9, -1, 2, '2023-01-02', 1, 2), (9, -1, 1, '2023-01-01', NULL, 1), (8, -1, -1, NULL, 2, 2), (5, 1, 1, '2023-01-01', 2, 2), (1, 1, 2, '2023-01-02', NULL, 1), (0, 2, 0, NULL, 2, 2), (3, 2, NULL, '2023-01-01', 1, NULL), (NULL, NULL, 0, '2023-01-01', 1, 2), (5, 2, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING (MAX(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) + MIN(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN -1 ELSE 0 END)) = 1;

/*
Prediction Result:
(-1,)
*/