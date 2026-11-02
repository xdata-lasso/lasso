-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '%S8%', 1), (0, 'default1', NULL), (2, 'default1', 1), (3, 'default2', NULL), (4, '%S8%', 1), (5, '%IPHONE%', NULL), (6, '%IPHONE%', NULL), (7, 'default1', 1), (8, 'S8', NULL), (9, 'default1', 1), (10, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 1, NULL, NULL, NULL), (9, NULL, NULL, '2023-01-02', 1, NULL), (8, 1, NULL, '2023-01-01', NULL, NULL), (4, NULL, 0, '2023-01-01', 1, 1), (8, 0, 1, '2023-01-01', NULL, 1), (8, NULL, 0, '2023-01-02', 1, NULL), (0, 0, 1, '2023-01-02', 1, 1), (4, NULL, 0, NULL, 1, NULL), (NULL, 1, NULL, '2023-01-02', NULL, NULL), (5, 0, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(1,)
(0,)
*/

-- Prediction Query
SELECT P.BUYER_ID FROM (SELECT SALES.BUYER_ID, GROUP_CONCAT(PRODUCT.PRODUCT_NAME) AS PRODUCTS FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY SALES.BUYER_ID HAVING PRODUCTS NOT LIKE '%IPHONE%' AND PRODUCTS LIKE '%S8%') AS P;

/*
Prediction Result:
(None,)
(0,)
*/