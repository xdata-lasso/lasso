-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (-1, 'S8', NULL), (1, NULL, NULL), (2, NULL, 1), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'iPhone', 1), (6, NULL, 1), (7, NULL, 1), (8, 'default1', NULL), (9, 'default2', NULL), (10, 'iPhone', NULL), (11, 'iPhone', NULL), (12, 'S8', 1), (13, 'default1', NULL), (14, 'default2', 1), (15, 'iPhone', 1), (16, 'iPhone', 1), (17, 'S8', 1), (18, NULL, 1), (19, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, 0, '2023-01-02', 1, 1), (0, 1, 0, '2023-01-01', NULL, NULL), (3, -1, 1, '2023-01-02', NULL, 1), (2, 1, 0, '2023-01-01', 1, NULL), (17, 1, -1, '2023-01-02', 1, NULL), (NULL, 1, 0, '2023-01-02', NULL, 1), (3, 0, -1, '2023-01-02', NULL, NULL), (6, NULL, 0, NULL, NULL, NULL), (10, -1, -1, NULL, NULL, 1), (NULL, -1, 1, '2023-01-01', NULL, 1), (8, 0, -1, '2023-01-02', NULL, NULL), (12, -1, NULL, NULL, NULL, 1), (16, NULL, 0, '2023-01-01', NULL, NULL), (1, 0, NULL, NULL, NULL, 1), (19, 1, 0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'S8') AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/