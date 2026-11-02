-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (2, 'S8', 1), (1, 'default2', 2), (3, 'default2', 1), (4, 'default1', NULL), (5, 'S8', 2), (6, 'S8', 2), (7, 'iPhone', 2), (8, 'S8', 2), (9, 'default1', 2), (10, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 0, 1, '2023-01-02', 2, NULL), (0, 2, NULL, '2023-01-01', 1, 2), (4, 2, 1, '2023-01-01', NULL, 2), (8, 0, NULL, '2023-01-01', 1, 2), (4, 1, 1, '2023-01-01', 2, 2), (3, 1, 1, '2023-01-02', 1, 2), (6, NULL, 2, '2023-01-01', 2, 2), (2, 2, NULL, NULL, NULL, 2), (6, 2, 2, '2023-01-01', 2, NULL), (5, 2, 2, '2023-01-01', 1, 1), (4, 1, NULL, NULL, 2, 2), (5, NULL, 2, '2023-01-01', 2, NULL), (NULL, NULL, 1, NULL, 1, 1), (NULL, 1, 2, NULL, 1, 1), (1, 2, 2, NULL, 2, 1), (5, 2, 0, '2023-01-01', 1, 1), (0, 1, 1, '2023-01-01', 1, NULL), (10, 2, NULL, '2023-01-02', 2, NULL), (NULL, NULL, 1, NULL, NULL, 1), (3, NULL, NULL, '2023-01-01', 2, NULL), (4, NULL, 0, '2023-01-02', NULL, NULL), (9, NULL, 1, '2023-01-02', NULL, 2), (3, NULL, 1, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(2,)
(0,)
*/

-- Prediction Query
WITH IPHONEBUYER AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM IPHONEBUYER) ORDER BY 1, BUYER_ID NULLS LAST;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/