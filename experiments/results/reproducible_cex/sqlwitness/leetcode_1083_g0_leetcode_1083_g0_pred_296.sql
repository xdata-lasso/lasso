-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'iPhone', 1), (-1, 'default2', 2), (2, 'S8', 1), (3, 'default2', 2), (4, 'default1', 1), (5, 'S8', NULL), (6, 'default2', 2), (7, 'default1', 2), (8, 'iPhone', 2), (9, NULL, 1), (10, 'default1', 1), (11, 'default1', 1), (12, 'S8', NULL), (13, 'S8', NULL), (14, NULL, 1), (15, 'S8', 1), (16, NULL, NULL), (17, 'default1', 2), (18, 'S8', 2), (19, NULL, NULL), (20, 'default1', NULL), (21, 'S8', 2), (22, 'default1', NULL), (23, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 2, 1, NULL, 1, 1), (21, NULL, 1, NULL, 2, 1), (10, 0, 1, NULL, 2, 2), (1, 0, 1, NULL, 1, 2), (4, NULL, NULL, '2023-01-01', 1, 1), (7, -1, -1, '2023-01-02', 2, 1), (10, NULL, NULL, NULL, NULL, 1), (18, 0, NULL, NULL, 2, 1), (18, -1, 1, '2023-01-02', NULL, 1), (22, 0, 2, '2023-01-02', 2, 2), (0, 1, -1, '2023-01-02', 1, 1), (2, -1, NULL, NULL, NULL, 1), (2, NULL, 2, '2023-01-02', 2, NULL), (21, 0, -1, '2023-01-01', NULL, 2), (17, -1, NULL, NULL, 1, 1), (NULL, -1, NULL, '2023-01-02', NULL, 2), (11, NULL, 2, NULL, NULL, 2), (16, 1, 2, '2023-01-01', 2, 1), (0, 0, 0, '2023-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.BUYER_ID HAVING SUM(B.PRODUCT_NAME = 'S8') >= 1 AND SUM(B.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(1,)
(2,)
*/