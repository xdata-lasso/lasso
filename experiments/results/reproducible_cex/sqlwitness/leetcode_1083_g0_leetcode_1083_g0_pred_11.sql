-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (-1, 'S8', NULL), (0, 'iPhone', 1), (2, 'default2', NULL), (3, NULL, NULL), (4, NULL, 1), (5, 'S8', 1), (6, 'S8', NULL), (7, NULL, NULL), (8, 'default1', 1), (9, 'S8', NULL), (10, 'default2', 1), (11, NULL, 1), (12, NULL, NULL), (13, 'default1', 1), (14, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, -1, -1, NULL, 1, NULL), (12, 0, NULL, NULL, 1, NULL), (2, -1, -1, NULL, NULL, 1), (10, NULL, 1, NULL, NULL, NULL), (0, 0, -1, '2023-01-02', 1, 1), (8, NULL, 0, NULL, 1, NULL), (13, NULL, -1, '2023-01-01', NULL, NULL), (1, -1, 0, NULL, NULL, 1), (-1, 0, 0, '2023-01-01', 1, NULL), (7, NULL, 1, NULL, 1, 1), (0, 1, 0, NULL, NULL, NULL), (4, -1, 0, NULL, 1, 1), (0, -1, 1, NULL, 1, 1), (2, 0, -1, '2023-01-01', NULL, NULL), (14, 1, NULL, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM PRODUCT CROSS JOIN SALES WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(PRODUCT.PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/