-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (0, NULL, NULL), (1, NULL, NULL), (2, NULL, 1), (3, 'iPhone', NULL), (4, 'default1', NULL), (5, NULL, NULL), (6, 'S8', 1), (7, 'S8', NULL), (8, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, NULL, '2023-01-02', NULL, 1), (NULL, NULL, 1, '2023-01-02', NULL, NULL), (-1, -1, 1, '2023-01-02', NULL, 1), (0, NULL, 0, '2023-01-01', NULL, NULL), (5, NULL, 1, NULL, 1, NULL), (5, NULL, -1, '2023-01-01', NULL, NULL), (6, 0, 1, '2023-01-01', 1, NULL), (-1, 0, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING SUM(B.PRODUCT_NAME = 'S8') > 0 AND SUM(B.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(1,)
*/