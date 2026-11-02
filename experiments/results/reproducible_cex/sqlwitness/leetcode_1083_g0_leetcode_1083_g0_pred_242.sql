-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', NULL), (1, 'default2', NULL), (2, 'iPhone', NULL), (3, NULL, 1), (4, 'default1', NULL), (5, 'default2', NULL), (6, 'default1', 1), (7, 'default2', 1), (8, 'iPhone', NULL), (9, 'default2', NULL), (10, 'S8', NULL), (11, 'default1', NULL), (12, NULL, NULL), (13, 'default2', 1), (14, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, NULL, '2023-01-01', NULL, NULL), (9, NULL, 1, '2023-01-02', 1, 1), (10, NULL, NULL, NULL, 1, NULL), (10, 1, 1, '2023-01-02', NULL, 1), (7, NULL, NULL, NULL, 1, NULL), (9, 1, 0, '2023-01-01', 1, 1), (3, NULL, 0, '2023-01-01', NULL, 1), (1, NULL, 0, '2023-01-01', 1, NULL), (12, 1, NULL, '2023-01-01', NULL, 1), (13, NULL, 1, '2023-01-01', NULL, 1), (7, NULL, 1, '2023-01-01', 1, NULL), (0, 1, NULL, NULL, 1, NULL), (11, NULL, 0, NULL, 1, 1), (7, NULL, 0, '2023-01-01', NULL, 1), (8, 0, 0, NULL, NULL, 1), (9, NULL, NULL, '2023-01-01', NULL, 1), (11, 0, 0, '2023-01-01', 1, 1), (1, NULL, 0, NULL, NULL, 1), (3, 0, NULL, NULL, NULL, 1), (10, NULL, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TEMP AS (SELECT * FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID)) SELECT DISTINCT BUYER_ID FROM TEMP WHERE NOT BUYER_ID IN (SELECT A.BUYER_ID FROM TEMP AS A JOIN TEMP AS B ON A.BUYER_ID = B.BUYER_ID WHERE A.PRODUCT_NAME = 'S8' AND B.PRODUCT_NAME = 'iPhone') AND PRODUCT_NAME = 'S8';

/*
Prediction Result:
(None,)
(1,)
*/