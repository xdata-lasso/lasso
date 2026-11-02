-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'S8', NULL), (2, 'S8', NULL), (3, NULL, NULL), (4, 'S8', 1), (5, 'iPhone', 1), (6, 'iPhone', 1), (7, NULL, NULL), (8, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 0, NULL, '2023-01-02', NULL, 1), (0, 0, 0, '2023-01-01', NULL, NULL), (4, 0, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(1,)
*/

-- Prediction Query
WITH COMB AS (SELECT P.PRODUCT_ID AS PID, P.PRODUCT_NAME AS NAME, S.BUYER_ID AS BID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT (BID) AS BUYER_ID FROM COMB WHERE BID IN (SELECT BID FROM COMB WHERE NAME = 'S8') AND NOT BID IN (SELECT BID FROM COMB WHERE NAME = 'iPhone');

/*
Prediction Result:
(1,)
*/