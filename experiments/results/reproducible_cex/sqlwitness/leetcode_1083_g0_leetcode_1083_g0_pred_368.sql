-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, 'iPhone', NULL), (2, NULL, NULL), (3, 'default1', NULL), (4, 'default1', NULL), (5, 'S8', NULL), (6, 'iPhone', 1), (7, 'default1', NULL), (8, NULL, 1), (9, 'S8', 1), (10, NULL, NULL), (11, NULL, 1), (12, 'S8', NULL), (13, NULL, 1), (14, 'default1', 1), (15, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (14, 1, NULL, '2023-01-01', NULL, 1), (2, 1, NULL, '2023-01-01', 1, 1), (14, 1, 1, NULL, 1, 1), (8, NULL, 1, '2023-01-01', 1, 1), (5, 0, NULL, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT DISTINCT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT DISTINCT A.BUYER_ID FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/