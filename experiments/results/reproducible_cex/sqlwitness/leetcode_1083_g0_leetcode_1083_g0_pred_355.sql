-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', NULL), (1, 'default1', NULL), (-1, 'default2', 1), (2, 'default2', NULL), (3, 'default1', NULL), (4, 'iPhone', NULL), (5, 'default2', NULL), (6, 'iPhone', NULL), (7, 'default2', 1), (8, 'iPhone', 1), (9, NULL, 1), (10, 'default1', NULL), (11, 'S8', NULL), (12, NULL, NULL), (13, 'default1', NULL), (14, NULL, 1), (15, NULL, 1), (16, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, -1, 0, '2023-01-01', 1, NULL), (14, -1, 0, NULL, 1, NULL), (1, -1, NULL, NULL, 1, 1), (10, 0, NULL, '2023-01-02', 1, 1), (NULL, 1, 0, '2023-01-02', NULL, 1), (6, NULL, -1, '2023-01-01', NULL, 1), (13, 1, NULL, '2023-01-02', NULL, 1), (11, 1, NULL, NULL, NULL, NULL), (5, -1, -1, '2023-01-02', NULL, 1), (11, NULL, -1, NULL, NULL, NULL), (16, 1, -1, '2023-01-01', 1, 1), (12, 1, 1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT_NAME = 'iPhone') = 0 AND SUM(PRODUCT_NAME = 'S8') <> 0;

/*
Prediction Result:
(None,)
*/