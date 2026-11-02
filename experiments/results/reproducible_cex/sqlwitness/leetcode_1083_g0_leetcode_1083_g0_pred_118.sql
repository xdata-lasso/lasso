-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (-1, 'default1', NULL), (0, 'iPhone', 1), (1, 'default1', 1), (3, 'S8', 1), (4, 'S8', NULL), (5, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, -1, NULL, NULL, 1, NULL), (3, 1, NULL, NULL, 1, 2), (0, 2, 1, '2023-01-01', 1, 2), (2, 2, 1, '2023-01-01', 1, NULL), (0, 1, 1, '2023-01-01', 2, 2), (3, 1, NULL, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT A.BUYER_ID, SUM(CASE WHEN B.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_SALES, SUM(CASE WHEN B.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_SALES FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID) AS C WHERE IPHONE_SALES = 0 AND S8_SALES >= 1;

/*
Prediction Result:
(None,)
*/