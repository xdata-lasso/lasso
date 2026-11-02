-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, NULL, NULL), (2, 'default1', 1), (3, 'iPhone', NULL), (4, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 1, '2023-01-02', 1, 1), (4, NULL, NULL, NULL, NULL, NULL), (0, 1, 0, '2023-01-01', NULL, 1), (4, NULL, NULL, '2023-01-02', 1, NULL), (0, NULL, 1, '2023-01-01', NULL, 1), (1, 1, NULL, '2023-01-02', 1, 1), (3, 0, NULL, '2023-01-02', NULL, NULL), (1, 1, 1, NULL, NULL, NULL), (2, 1, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH S8_BUYERS AS (SELECT DISTINCT (S.BUYER_ID) FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), IPHONE_BUYERS AS (SELECT DISTINCT (S.BUYER_ID) FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT X.BUYER_ID FROM S8_BUYERS AS X LEFT JOIN IPHONE_BUYERS AS Y ON X.BUYER_ID = Y.BUYER_ID WHERE Y.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/