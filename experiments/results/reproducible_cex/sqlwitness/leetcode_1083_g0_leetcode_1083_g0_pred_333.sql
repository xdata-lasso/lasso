-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1), (0, 'default2', 2), (-1, 'default2', 2), (1, 'S8', 2), (3, NULL, NULL), (4, NULL, 1), (5, 'iPhone', 2), (6, 'S8', NULL), (7, 'default2', NULL), (8, 'S8', 2), (9, 'iPhone', 1), (10, NULL, 2), (11, NULL, 1), (12, NULL, 2), (13, 'default2', NULL), (14, 'default2', 2), (15, 'S8', 1), (16, 'S8', 2), (17, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, NULL, NULL, 1, 1), (9, 1, 0, NULL, NULL, NULL), (13, 0, NULL, '2023-01-01', 2, 2), (16, NULL, -1, NULL, NULL, 2), (10, -1, -1, NULL, 2, 2), (0, 0, 0, '2023-01-02', 2, NULL), (0, NULL, 1, NULL, 2, 1), (6, 2, 2, '2023-01-02', 2, NULL), (NULL, 0, 0, '2023-01-02', 2, 2), (16, 0, 1, '2023-01-02', 1, NULL), (-1, 0, NULL, '2023-01-02', 1, NULL), (10, 2, NULL, NULL, 2, NULL), (NULL, NULL, 0, '2023-01-01', 2, 1), (NULL, 0, 2, '2023-01-02', NULL, 1), (9, 2, 0, NULL, 2, 1), (7, NULL, NULL, '2023-01-02', 1, 2), (15, NULL, 0, NULL, 1, NULL), (10, NULL, -1, '2023-01-02', 1, 2), (4, 1, 1, NULL, 1, 2), (13, NULL, 2, '2023-01-02', 2, NULL), (16, 2, 2, NULL, 1, NULL), (14, 2, NULL, '2023-01-02', NULL, 1), (15, 2, -1, '2023-01-01', NULL, 1), (7, 0, 0, '2023-01-01', NULL, 2), (9, 2, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH TABLE1 AS (SELECT S.BUYER_ID, SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) GROUP BY S.BUYER_ID) SELECT BUYER_ID FROM TABLE1 WHERE S8 > 0 AND IPHONE = 0;

/*
Prediction Result:
(-1,)
(1,)
(2,)
*/