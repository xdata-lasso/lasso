-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'iPhone', 1), (1, 'S8', 1), (2, 'default2', NULL), (3, 'S8', NULL), (4, 'S8', NULL), (5, 'default2', NULL), (6, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, NULL, '2023-01-01', NULL, NULL), (1, 0, 1, '2023-01-01', NULL, NULL), (2, NULL, NULL, '2023-01-01', 1, 1), (NULL, 1, NULL, '2023-01-02', NULL, 1), (3, NULL, 1, '2023-01-02', NULL, NULL), (4, 1, 1, NULL, 1, 1), (2, 1, NULL, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH PRODUCT_BUYER AS (SELECT DISTINCT PRODUCT_NAME, BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT P1.BUYER_ID FROM PRODUCT_BUYER AS P1 LEFT JOIN PRODUCT_BUYER AS P2 ON P1.BUYER_ID = P2.BUYER_ID AND P2.PRODUCT_NAME = 'iPhone' WHERE P1.PRODUCT_NAME = 'S8' AND P2.BUYER_ID IS NULL;

/*
Prediction Result:
(1,)
*/