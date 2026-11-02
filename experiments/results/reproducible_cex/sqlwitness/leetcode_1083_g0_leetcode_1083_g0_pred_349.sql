-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (2, 'S8', 1), (-1, 'default2', 2), (0, 'iPhone', 2), (3, 'iPhone', 1), (4, 'S8', 1), (5, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, -1, '2023-01-02', 2, 1), (NULL, 0, 2, '2023-01-02', NULL, NULL), (-1, 2, 0, '2023-01-02', NULL, 1), (5, NULL, NULL, '2023-01-02', NULL, 1), (4, NULL, NULL, '2023-01-02', 2, NULL), (5, 2, 0, '2023-01-02', 2, 1), (1, -1, -1, '2023-01-02', NULL, 1), (5, -1, NULL, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT K.BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS COUNTS8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS COUNT_IPHONE FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING COUNTS8 >= 1 AND COUNT_IPHONE = 0) AS K;

/*
Prediction Result:
(None,)
*/