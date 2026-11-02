-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (2, 'S8', 2), (1, 'default2', 2), (3, NULL, 2), (4, 'S8', 1), (5, NULL, 1), (6, 'iPhone', NULL), (7, 'default2', 1), (8, 'S8', 1), (9, 'S8', 1), (10, 'iPhone', 2), (11, NULL, NULL), (12, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, 1, '2023-01-01', 2, 2), (8, NULL, 1, '2023-01-02', 1, 2), (1, NULL, NULL, '2023-01-01', NULL, 1), (6, NULL, NULL, '2023-01-01', 1, 1), (0, 2, 1, '2023-01-01', NULL, 1), (10, 0, 1, NULL, 1, NULL), (4, 0, 2, '2023-01-01', 2, NULL), (2, 2, 1, '2023-01-02', 2, 2), (NULL, 1, NULL, NULL, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, CASE WHEN PRODUCT.PRODUCT_NAME = 'S8' THEN 1 WHEN PRODUCT.PRODUCT_NAME = 'iPhone' THEN -1 END AS COEFF FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID AND (PRODUCT.PRODUCT_NAME = 'S8' OR PRODUCT.PRODUCT_NAME = 'iPhone') GROUP BY BUYER_ID, PRODUCT.PRODUCT_NAME) AS SALES_INFO GROUP BY BUYER_ID HAVING SUM(COEFF) = 1;

/*
Prediction Result:
(2,)
*/