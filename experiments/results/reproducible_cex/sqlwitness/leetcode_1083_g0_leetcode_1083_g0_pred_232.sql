-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'iPhone', NULL), (2, 'default1', NULL), (3, 'S8', 1), (4, 'S8', 1), (5, 'default1', 1), (6, 'default1', 1), (7, 'iPhone', 1), (8, 'default2', NULL), (9, 'iPhone', 1), (10, NULL, 1), (11, 'default2', 1), (12, 'default1', 1), (13, 'default1', 1), (14, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, 1, '2023-01-02', 1, NULL), (13, 1, 1, NULL, 1, 1), (13, NULL, NULL, NULL, 1, NULL), (14, NULL, NULL, NULL, NULL, 1), (2, 0, 0, '2023-01-02', 1, 1), (6, NULL, NULL, '2023-01-01', NULL, NULL), (14, 0, 0, '2023-01-01', 1, NULL), (4, 1, 0, '2023-01-01', NULL, NULL), (10, NULL, NULL, NULL, NULL, NULL), (3, NULL, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(None,)
*/

-- Prediction Query
WITH SALES_WITH_PRODUCT AS (SELECT A.BUYER_ID, A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES_WITH_PRODUCT WHERE PRODUCT_NAME = 'iPhone') GROUP BY BUYER_ID;

/*
Prediction Result:
(0,)
*/