-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', NULL), (1, 'S8', NULL), (0, 'default1', 1), (3, 'default1', 1), (4, 'S8', 1), (5, 'default1', 2), (6, 'iPhone', 1), (7, 'S8', 2), (8, NULL, 1), (9, 'S8', 2), (10, 'S8', 2), (11, 'default2', 1), (12, 'iPhone', NULL), (13, NULL, NULL), (14, 'S8', NULL), (15, 'S8', 1), (16, NULL, NULL), (17, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 2, 0, '2023-01-01', NULL, 2), (17, 0, NULL, NULL, 2, 2), (6, 2, 2, NULL, 1, 1), (1, 2, 1, NULL, NULL, 1), (1, 2, NULL, '2023-01-02', 1, 1), (11, 0, 1, '2023-01-02', NULL, NULL), (12, 0, 2, NULL, NULL, 1), (15, 0, NULL, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE PRODUCT_NAME IN ('iPhone', 'S8') GROUP BY BUYER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 1 AND PRODUCT_NAME = 'S8') AS TMP;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/