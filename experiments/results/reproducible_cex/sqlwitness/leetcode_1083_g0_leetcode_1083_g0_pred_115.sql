-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (-1, 'S8', 2), (2, NULL, 1), (1, 'S8', 1), (3, NULL, 1), (4, NULL, 2), (5, 'default2', 1), (6, 'default2', 1), (7, 'S8', 1), (8, 'S8', 2), (9, 'default2', 2), (10, 'default2', 2), (11, 'S8', 1), (12, 'default2', 1), (13, 'iPhone', 1), (14, 'default1', NULL), (15, NULL, NULL), (16, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 0, 1, '2023-01-01', NULL, 1), (16, 1, 1, NULL, 1, 2), (2, 1, NULL, '2023-01-02', 1, 2), (7, -1, 2, NULL, 2, 1), (7, 0, 2, NULL, NULL, NULL), (7, -1, NULL, '2023-01-02', 1, 1), (1, NULL, 0, NULL, 2, NULL), (1, 2, -1, '2023-01-01', NULL, NULL), (8, 0, 1, '2023-01-01', 2, 1), (11, NULL, 1, '2023-01-01', NULL, 1), (NULL, NULL, 2, '2023-01-02', NULL, 2), (1, 1, 1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(2,)
(0,)
(-1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_FLAG, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_FLAG FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID) AS A WHERE S8_FLAG >= 1 AND IPHONE_FLAG = 0;

/*
Prediction Result:
(None,)
(-1,)
(0,)
(2,)
*/