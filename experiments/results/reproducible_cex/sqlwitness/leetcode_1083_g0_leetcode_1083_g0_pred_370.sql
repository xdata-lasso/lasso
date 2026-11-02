-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 2), (2, 'iPhone', NULL), (-1, 'default2', NULL), (1, NULL, 1), (3, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, NULL, '2023-01-02', NULL, 2), (NULL, NULL, NULL, NULL, 1, 1), (3, 1, -1, '2023-01-02', 2, 2), (1, 1, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN P1.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_CNT, SUM(CASE WHEN P1.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_CNT FROM SALES AS S1 INNER JOIN PRODUCT AS P1 ON S1.PRODUCT_ID = P1.PRODUCT_ID GROUP BY BUYER_ID) AS PC WHERE S8_CNT > 0 AND IPHONE_CNT = 0;

/*
Prediction Result:
(-1,)
*/