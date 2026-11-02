-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (2, 'iPhone', 2), (1, NULL, 2), (-1, NULL, 2), (3, 'S8', NULL), (4, 'S8', 2), (5, 'iPhone', NULL), (6, 'iPhone', NULL), (7, 'default1', 2), (8, 'default1', 2), (9, 'default2', 2), (10, 'default2', 1), (11, NULL, NULL), (12, 'iPhone', 1), (13, NULL, 1), (14, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 0, NULL, NULL, 2, NULL), (10, 1, NULL, NULL, 1, 1), (NULL, -1, -1, NULL, 2, 2), (3, 0, NULL, NULL, 2, NULL), (0, 1, -1, NULL, NULL, 1), (13, 2, 2, '2023-01-01', 2, NULL), (13, 1, -1, '2023-01-02', 1, 1), (-1, 2, 0, NULL, NULL, NULL), (NULL, 0, -1, NULL, 1, 2), (-1, 2, -1, NULL, 2, NULL), (9, 0, 1, NULL, 1, NULL), (9, 1, 2, NULL, 1, NULL), (14, 0, 0, '2023-01-02', NULL, 2), (6, 1, NULL, '2023-01-02', NULL, NULL), (7, 1, 0, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, MAX(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS BOUGHT_IPHONE, MAX(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS BOUGHT_S8 FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY BUYER_ID) AS A WHERE BOUGHT_IPHONE = 0 AND BOUGHT_S8 = 1;

/*
Prediction Result:
(0,)
*/