-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (-1, 'S8', NULL), (0, 'default1', 1), (2, 'S8', NULL), (3, 'iPhone', NULL), (4, 'S8', 1), (5, 'S8', 1), (6, 'default1', NULL), (7, 'default1', 1), (8, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 0, NULL, NULL, NULL), (0, 1, NULL, NULL, 1, NULL), (NULL, -1, -1, NULL, NULL, 1), (7, -1, -1, NULL, 1, NULL), (8, 1, -1, '2023-01-01', 1, 1), (2, 0, NULL, '2023-01-01', 1, 1), (7, 1, -1, NULL, 1, NULL), (5, NULL, 0, '2023-01-02', 1, 1), (2, 1, 0, NULL, 1, NULL), (1, 1, NULL, NULL, 1, NULL), (5, NULL, 0, '2023-01-01', NULL, NULL), (6, 0, -1, '2023-01-01', NULL, 1), (3, NULL, NULL, '2023-01-01', NULL, NULL), (5, 1, -1, NULL, 1, 1), (8, NULL, 0, NULL, 1, 1), (5, 1, NULL, '2023-01-02', NULL, NULL), (NULL, 1, 1, NULL, 1, NULL), (4, 0, NULL, NULL, 1, 1), (NULL, NULL, NULL, '2023-01-02', NULL, NULL), (4, 1, NULL, '2023-01-02', 1, NULL), (3, -1, 0, '2023-01-02', 1, NULL), (7, NULL, -1, '2023-01-02', NULL, NULL), (6, -1, -1, '2023-01-01', NULL, NULL), (-1, 0, -1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(-1,)
*/