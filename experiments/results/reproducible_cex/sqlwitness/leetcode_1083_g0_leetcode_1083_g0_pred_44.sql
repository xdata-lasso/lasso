-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (-1, 'iPhone', NULL), (1, 'S8', 1), (2, 'iPhone', 1), (3, 'default1', NULL), (4, 'default2', 1), (5, 'default1', 1), (6, 'S8', NULL), (7, 'iPhone', NULL), (8, 'default1', NULL), (9, 'S8', 1), (10, NULL, NULL), (11, 'S8', NULL), (12, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 1, NULL, 1, NULL), (6, -1, 1, NULL, NULL, 1), (8, 0, -1, '2023-01-02', NULL, 1), (9, 0, 1, NULL, NULL, NULL), (3, -1, -1, '2023-01-02', 1, NULL), (-1, 1, -1, '2023-01-01', 1, 1), (8, NULL, -1, '2023-01-02', 1, NULL), (12, NULL, -1, '2023-01-02', NULL, NULL), (5, -1, -1, '2023-01-02', NULL, 1), (12, NULL, 1, NULL, 1, 1), (6, 1, NULL, '2023-01-01', 1, NULL), (11, 0, -1, '2023-01-02', NULL, 1), (8, NULL, NULL, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT B.BUYER_ID FROM PRODUCT AS A JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY B.BUYER_ID HAVING SUM(A.PRODUCT_NAME = 'S8') > 0 AND SUM(A.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(1,)
*/