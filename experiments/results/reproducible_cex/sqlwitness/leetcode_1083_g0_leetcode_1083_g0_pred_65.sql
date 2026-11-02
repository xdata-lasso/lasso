-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, 'S8', NULL), (-1, 'default1', NULL), (2, 'default2', NULL), (3, 'S8', 1), (4, 'default2', 1), (5, 'iPhone', 1), (6, 'S8', NULL), (7, 'default2', 1), (8, NULL, 1), (9, NULL, 1), (10, 'S8', 1), (11, 'S8', NULL), (12, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, -1, '2023-01-02', NULL, 1), (9, NULL, NULL, '2023-01-01', NULL, NULL), (9, -1, NULL, NULL, 1, 1), (3, NULL, 0, '2023-01-02', 1, 1), (0, NULL, -1, '2023-01-01', 1, NULL), (4, -1, 1, '2023-01-02', NULL, 1), (5, 1, NULL, '2023-01-01', NULL, 1), (6, -1, 1, '2023-01-02', NULL, 1), (11, 1, -1, NULL, NULL, NULL), (4, -1, 0, '2023-01-02', NULL, 1), (8, 1, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(-1,)
(0,)
(1,)
*/