-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', NULL), (1, 'default1', 1), (2, '%S8%', 1), (3, 'iPhone', NULL), (4, '%S8%', 1), (5, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, NULL, '2023-01-02', 1, NULL), (2, 1, 1, '2023-01-02', 1, 1), (2, 1, 1, '2023-01-02', 1, 1), (5, 0, 0, '2023-01-01', 1, NULL), (2, 0, 1, '2023-01-01', 1, 1), (NULL, 1, 1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS PRODUCTS FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) AS T WHERE PRODUCTS LIKE '%S8%' AND PRODUCTS NOT LIKE '%IPHONE%';

/*
Prediction Result:
(0,)
(1,)
*/