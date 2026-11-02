-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (-1, 'default2', 1), (1, 'default1', 2), (2, NULL, NULL), (3, 'default2', 2), (4, NULL, 1), (5, NULL, NULL), (6, NULL, 2), (7, 'S8', 2), (8, 'default2', 2), (9, 'default1', 2), (10, 'S8', 2), (11, 'iPhone', NULL), (12, 'S8', NULL), (13, 'iPhone', NULL), (14, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 1, NULL, NULL, NULL, 2), (12, 2, -1, '2023-01-02', 1, NULL), (1, -1, 1, '2023-01-01', 1, NULL), (NULL, -1, -1, '2023-01-02', NULL, 2), (-1, -1, 2, NULL, 1, 2), (2, 1, -1, '2023-01-01', NULL, 1), (9, NULL, NULL, '2023-01-01', NULL, 2), (2, -1, -1, NULL, 2, 2), (8, NULL, NULL, '2023-01-02', NULL, 1), (0, NULL, 1, '2023-01-01', 2, 2), (4, -1, 0, NULL, 1, 1), (3, 1, 2, '2023-01-01', 2, NULL), (10, 2, NULL, NULL, 1, 2), (10, -1, NULL, '2023-01-02', NULL, 2), (10, -1, 1, '2023-01-01', 1, 1), (4, NULL, 2, '2023-01-01', 2, 2), (12, 0, 0, '2023-01-02', 1, 2), (11, 2, -1, '2023-01-02', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING MAX(IIF(PRODUCT_NAME = 'S8', 1, 0)) = 1 AND MAX(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(0,)
(1,)
*/