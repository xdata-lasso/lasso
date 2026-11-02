-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 1), (0, 'iPhone', 1), (1, 'default1', NULL), (3, NULL, NULL), (4, 'iPhone', 1), (5, 'iPhone', NULL), (6, NULL, NULL), (7, 'default1', 1), (8, 'S8', 2), (9, 'S8', 1), (10, 'default1', NULL), (11, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, NULL, NULL, NULL, 2), (NULL, 2, NULL, '2023-01-01', 2, 1), (6, NULL, 1, '2023-01-02', 2, 1), (4, 2, NULL, '2023-01-01', 1, 2), (9, 1, 2, '2023-01-01', 2, 2), (NULL, NULL, 2, '2023-01-02', NULL, NULL), (11, 0, 0, NULL, NULL, NULL), (2, 1, 0, NULL, 2, 2), (0, 2, 0, NULL, NULL, 1), (11, NULL, 1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT B.BUYER_ID, A.PRODUCT_NAME, DENSE_RANK() OVER (PARTITION BY B.BUYER_ID ORDER BY A.PRODUCT_NAME) AS BUY_RANK FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME IN ('S8', 'iPhone')) SELECT DISTINCT BUYER_ID FROM T WHERE BUY_RANK = 1 AND PRODUCT_NAME = 'S8';

/*
Prediction Result:
(None,)
(2,)
*/