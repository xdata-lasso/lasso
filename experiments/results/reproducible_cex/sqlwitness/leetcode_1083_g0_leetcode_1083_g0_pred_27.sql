-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, NULL, 1), (2, 'S8', 1), (3, 'S8', 1), (4, 'iPhone', 1), (5, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 1, NULL, 2, 2), (5, 1, NULL, '2023-01-01', 1, 2), (3, 1, NULL, '2023-01-02', NULL, 2), (0, NULL, NULL, NULL, 1, 1), (3, NULL, NULL, '2023-01-01', NULL, 1), (3, NULL, 0, NULL, 1, 2), (4, NULL, 0, '2023-01-01', 1, 1), (4, 2, 0, '2023-01-01', NULL, 1), (5, NULL, 0, '2023-01-02', NULL, 1), (2, 0, NULL, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME IN ('S8', 'iPhone') GROUP BY BUYER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 1 AND MAX(PRODUCT_NAME) = 'S8';

/*
Prediction Result:
(None,)
*/