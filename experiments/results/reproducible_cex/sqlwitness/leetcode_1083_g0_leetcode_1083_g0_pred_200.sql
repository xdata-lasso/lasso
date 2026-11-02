-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (3, 'iPhone', 3), (1, 'iPhone', 3), (0, 'default2', 2), (4, NULL, 3), (5, NULL, 1), (6, 'default1', NULL), (7, 'iPhone', NULL), (8, 'default2', 2), (9, 'S8', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 0, '2023-01-01', 3, 1), (4, NULL, 2, NULL, NULL, 2), (2, 1, NULL, NULL, 1, 2), (3, 3, NULL, '2023-01-01', 2, 1), (6, 0, NULL, '2023-01-01', 3, 1), (9, 2, 3, '2023-01-02', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH BUYERS AS (SELECT S.*, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME IN ('S8', 'iPhone')) SELECT DISTINCT BUYER_ID FROM BUYERS WHERE PRODUCT_NAME = 'S8' GROUP BY BUYER_ID HAVING NOT BUYER_ID IN (SELECT BUYER_ID FROM BUYERS GROUP BY BUYER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2);

/*
Prediction Result:
(3,)
*/