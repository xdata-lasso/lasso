-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, NULL, 1), (2, 'default2', NULL), (3, 'S8', NULL), (4, 'S8', NULL), (5, 'default2', 1), (6, 'default2', NULL), (7, NULL, 1), (8, 'iPhone', 1), (9, 'default2', 1), (10, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 0, 0, NULL, 1, NULL), (10, NULL, 0, '2023-01-01', NULL, NULL), (10, 1, 1, '2023-01-01', NULL, 1), (5, NULL, 1, '2023-01-01', NULL, NULL), (6, 0, 0, '2023-01-02', 1, 1), (3, 1, NULL, '2023-01-01', 1, NULL), (5, 1, 0, '2023-01-02', NULL, NULL), (1, NULL, 1, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(1,)
(None,)
*/

-- Prediction Query
WITH C1 AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')), C2 AS (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) SELECT BUYER_ID FROM C1 WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM C2);

/*
Prediction Result:
(1,)
*/