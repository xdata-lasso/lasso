-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'iPhone', NULL), (2, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 1, '2023-01-01', 1, NULL), (0, 1, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH S8_TAB AS (SELECT BUYER_ID FROM SALES AS SALES LEFT JOIN PRODUCT AS PROD ON SALES.PRODUCT_ID = PROD.PRODUCT_ID WHERE PRODUCT_NAME = 'S8'), IPHONE_TAB AS (SELECT BUYER_ID FROM SALES AS SALES LEFT JOIN PRODUCT AS PROD ON SALES.PRODUCT_ID = PROD.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT (BUYER_ID) FROM SALES WHERE BUYER_ID IN (SELECT * FROM S8_TAB) AND NOT BUYER_ID IN (SELECT * FROM IPHONE_TAB);

/*
Prediction Result:
*/