-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, 'default1', NULL), (2, 'default2', NULL), (3, 'S8', 1), (4, 'S8', 1), (5, 'S8', NULL), (6, 'default2', 1), (7, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, NULL, 0, '2023-01-02', NULL, NULL), (2, 1, 0, NULL, NULL, 1), (1, 1, NULL, '2023-01-01', 1, 1), (NULL, 0, 0, '2023-01-01', NULL, NULL), (NULL, NULL, 1, NULL, NULL, NULL), (0, 1, 1, '2023-01-01', NULL, NULL), (NULL, 1, NULL, '2023-01-02', NULL, 1), (4, NULL, 0, '2023-01-02', NULL, NULL), (NULL, 0, NULL, '2023-01-02', NULL, NULL), (0, NULL, NULL, '2023-01-02', 1, NULL), (NULL, 0, 1, '2023-01-01', 1, 1), (0, 0, 0, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
WITH S8_BUYERS AS (SELECT DISTINCT S.BUYER_ID, S.PRODUCT_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') SELECT BUYER_ID FROM S8_BUYERS WHERE NOT BUYER_ID IN (SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
(0,)
*/