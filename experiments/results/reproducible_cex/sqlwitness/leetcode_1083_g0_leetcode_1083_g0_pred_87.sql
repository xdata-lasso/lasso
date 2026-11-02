-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', NULL), (2, 'iPhone', 1), (0, 'S8', 2), (1, 'S8', 2), (3, 'iPhone', 2), (4, 'default1', 1), (5, 'iPhone', 1), (6, 'S8', 2), (7, 'default2', NULL), (8, NULL, 1), (9, 'default1', 2), (10, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, -1, NULL, NULL, 2), (4, -1, 2, '2023-01-01', 1, 2), (-1, 1, NULL, NULL, NULL, 2), (4, 2, -1, '2023-01-02', NULL, NULL), (-1, 0, 0, '2023-01-01', 1, 2), (7, NULL, -1, '2023-01-02', 2, NULL), (-1, 0, 2, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
WITH A AS (SELECT A.BUYER_ID, MAX(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS BOUGHT_S8, MAX(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS BOUGHT_IPHONE FROM SALES AS A INNER JOIN PRODUCT AS B ON B.PRODUCT_ID = A.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM A WHERE BOUGHT_S8 = 1 AND BOUGHT_IPHONE = 0;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/