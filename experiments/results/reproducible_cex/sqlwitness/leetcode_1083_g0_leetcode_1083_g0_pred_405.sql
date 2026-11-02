-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 2), (2, NULL, NULL), (-1, 'S8', 1), (0, 'iPhone', 1), (3, 'S8', NULL), (4, 'default1', 2), (5, 'iPhone', NULL), (6, 'default2', 2), (7, NULL, 1), (8, 'default2', 1), (9, NULL, 1), (10, 'iPhone', 1), (11, 'S8', 1), (12, 'S8', 2), (13, NULL, NULL), (14, 'default1', NULL), (15, 'iPhone', NULL), (16, 'S8', 1), (17, 'default2', 2), (18, 'iPhone', NULL), (19, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, NULL, 0, '2023-01-01', 2, NULL), (7, 1, -1, '2023-01-02', NULL, 2), (7, -1, 0, NULL, 1, 1), (9, 2, 1, '2023-01-01', NULL, 2), (6, 2, 0, '2023-01-01', 1, 1), (15, -1, -1, NULL, NULL, 1), (6, 2, 0, '2023-01-02', 2, 2), (15, 2, 2, '2023-01-02', 1, 1), (19, 0, 1, NULL, 2, 1), (3, 2, 0, NULL, 1, NULL), (12, 2, 0, '2023-01-01', 2, NULL), (0, -1, 1, NULL, 1, 2), (17, 0, 1, '2023-01-02', NULL, 2), (-1, -1, NULL, '2023-01-01', NULL, 1), (NULL, -1, -1, '2023-01-02', NULL, 1), (15, 2, 2, '2023-01-02', NULL, 1), (12, -1, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0 AND SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0;

/*
Prediction Result:
(None,)
(0,)
*/