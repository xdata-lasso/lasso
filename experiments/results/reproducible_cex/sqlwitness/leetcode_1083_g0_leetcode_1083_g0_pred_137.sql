-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (-1, 'default2', 2), (2, 'default2', NULL), (1, 'S8', 1), (3, 'default1', 1), (4, 'default2', 2), (5, 'default2', 1), (6, NULL, 1), (7, 'default1', 2), (8, 'iPhone', 1), (9, 'S8', 1), (10, 'default2', 2), (11, NULL, 1), (12, 'default1', 2), (13, 'S8', 2), (14, 'S8', 2), (15, 'default1', NULL), (16, 'default1', 1), (17, 'default2', 1), (18, 'default1', NULL), (19, 'S8', NULL), (20, 'default1', 2), (21, 'iPhone', NULL), (22, 'S8', 2), (23, 'iPhone', NULL), (24, 'default1', 2), (25, 'default1', NULL), (26, 'S8', 2), (27, 'iPhone', 1), (28, NULL, NULL), (29, 'default2', 2), (30, 'default2', 2), (31, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (26, -1, NULL, '2023-01-02', 2, 1), (31, -1, 2, NULL, NULL, 2), (-1, 1, 2, '2023-01-01', 1, 2), (7, NULL, NULL, '2023-01-02', NULL, 1), (6, NULL, NULL, '2023-01-02', NULL, 1), (28, 2, 0, '2023-01-01', 1, NULL), (0, 1, NULL, NULL, NULL, 2), (29, 1, 0, NULL, 1, 2), (28, -1, NULL, NULL, 1, 1), (19, 0, 2, NULL, 1, 2), (9, 0, NULL, NULL, 1, NULL), (4, NULL, 0, '2023-01-02', NULL, 2), (31, NULL, 1, NULL, NULL, NULL), (4, 2, 0, '2023-01-02', 1, NULL), (20, 2, 0, NULL, 1, NULL), (29, 2, 2, '2023-01-02', 2, NULL), (1, -1, 0, '2023-01-02', 2, 2), (16, -1, 1, '2023-01-02', 1, NULL), (0, NULL, -1, '2023-01-02', 1, NULL), (5, 2, 2, '2023-01-01', 2, NULL), (5, 1, NULL, NULL, 2, 2), (-1, -1, 0, '2023-01-01', 1, NULL), (19, NULL, -1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, (CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, (CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) AS Z GROUP BY 1 HAVING SUM(S8) > 0 AND SUM(IPHONE) = 0;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/