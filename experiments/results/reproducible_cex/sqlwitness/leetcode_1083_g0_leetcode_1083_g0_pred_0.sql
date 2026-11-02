-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (2, 'default1', NULL), (-1, 'default2', NULL), (0, 'S8', NULL), (3, 'S8', 1), (4, 'iPhone', NULL), (5, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, 2, '2023-01-02', 1, NULL), (NULL, 0, 0, NULL, 1, 2), (5, 0, 2, NULL, NULL, NULL), (-1, 0, -1, '2023-01-01', 1, 2), (3, 0, 0, '2023-01-02', NULL, 1), (5, 0, 1, '2023-01-02', NULL, 2), (5, 1, 0, '2023-01-01', NULL, NULL), (NULL, -1, -1, '2023-01-01', 1, NULL), (4, NULL, 1, '2023-01-02', 1, 1), (-1, 0, NULL, '2023-01-02', NULL, 1), (3, NULL, NULL, '2023-01-01', 1, 1), (3, 0, 2, '2023-01-02', 1, 1), (5, NULL, 2, NULL, NULL, 1), (4, -1, NULL, '2023-01-01', 2, 2), (5, NULL, 2, '2023-01-01', NULL, 1), (4, NULL, NULL, '2023-01-01', 1, 1), (4, NULL, -1, '2023-01-02', 2, NULL), (2, -1, 0, NULL, 2, 1), (4, NULL, 1, '2023-01-01', 2, 1), (1, -1, -1, '2023-01-02', 1, NULL), (-1, 0, -1, '2023-01-01', 1, 2), (-1, 2, 2, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING SUM(CASE WHEN B.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN B.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(0,)
*/