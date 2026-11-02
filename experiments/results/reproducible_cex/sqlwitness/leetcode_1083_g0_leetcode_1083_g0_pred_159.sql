-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'default1', 2), (2, 'iPhone', 2), (-1, 'S8', 2), (3, 'iPhone', 2), (4, 'iPhone', 2), (5, 'default1', 1), (6, NULL, 2), (7, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, NULL, '2023-01-02', 2, 1), (4, 2, 2, NULL, NULL, 1), (5, -1, -1, NULL, 1, NULL), (2, 0, -1, '2023-01-01', 1, NULL), (5, 0, 0, '2023-01-02', NULL, 2), (-1, 1, 0, '2023-01-02', 2, 1), (4, -1, NULL, NULL, NULL, NULL), (0, 1, 0, '2023-01-02', NULL, 1), (5, 2, 1, '2023-01-01', 2, 1), (5, 0, 0, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') > 0 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(0,)
*/