-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'S8', NULL), (2, 'iPhone', NULL), (3, 'S8', NULL), (4, 'iPhone', 1), (5, 'default2', NULL), (6, 'iPhone', 1), (7, 'S8', 1), (8, 'default1', 1), (9, 'S8', NULL), (10, 'iPhone', 1), (11, 'default1', 1), (12, 'iPhone', NULL), (13, 'S8', NULL), (14, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, 1, NULL, '2023-01-01', 1, 1), (7, NULL, 0, NULL, 1, 1), (9, 0, NULL, NULL, NULL, 1), (5, 1, 1, NULL, NULL, 1), (13, NULL, 0, NULL, NULL, 1), (14, 0, 1, NULL, 1, 1), (5, 1, 1, '2023-01-01', NULL, 1), (11, 0, 1, '2023-01-01', 1, 1), (3, 0, NULL, '2023-01-01', NULL, NULL), (3, NULL, NULL, '2023-01-01', 1, 1), (10, 0, 0, '2023-01-01', 1, 1), (6, NULL, NULL, NULL, NULL, 1), (6, 1, 0, '2023-01-01', NULL, NULL), (8, NULL, 1, NULL, NULL, NULL), (3, NULL, 1, '2023-01-02', 1, NULL), (9, NULL, NULL, NULL, 1, NULL), (14, 1, NULL, '2023-01-01', 1, 1), (13, NULL, 0, '2023-01-02', 1, 1), (13, NULL, NULL, NULL, 1, 1), (2, NULL, NULL, '2023-01-02', 1, NULL), (10, NULL, 0, '2023-01-02', 1, NULL), (4, 1, 1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) AS S LEFT OUTER JOIN (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) AS I ON S.BUYER_ID = I.BUYER_ID WHERE I.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/