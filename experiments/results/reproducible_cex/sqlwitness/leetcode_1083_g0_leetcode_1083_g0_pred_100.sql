-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, 'default1', 1), (2, 'default1', 1), (3, 'default1', NULL), (4, 'default2', NULL), (5, 'S8', 1), (6, NULL, NULL), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 1, '2023-01-01', NULL, 1), (6, 0, 0, NULL, NULL, 1), (6, 1, NULL, '2023-01-02', 1, NULL), (5, NULL, 1, '2023-01-02', 1, NULL), (5, 1, 0, '2023-01-02', 1, 1), (5, 1, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(0,)
(None,)
*/

-- Prediction Query
WITH T1 AS (SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8'), T2 AS (SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') SELECT DISTINCT BUYER_ID FROM T1 WHERE NOT BUYER_ID IN (SELECT * FROM T2) ORDER BY BUYER_ID;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/