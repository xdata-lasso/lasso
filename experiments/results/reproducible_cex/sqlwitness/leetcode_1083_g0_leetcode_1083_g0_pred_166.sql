-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, 'S8', NULL), (2, NULL, NULL), (3, 'default2', 1), (4, 'S8', NULL), (5, 'default2', NULL), (6, 'default1', NULL), (7, 'S8', 1), (8, 'iPhone', NULL), (9, 'S8', NULL), (10, 'S8', NULL), (11, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, NULL, NULL, 1, NULL), (6, 0, 0, '2023-01-02', NULL, NULL), (5, NULL, NULL, '2023-01-01', NULL, NULL), (1, 1, 0, '2023-01-02', NULL, 1), (9, 0, 1, '2023-01-02', 1, NULL), (9, NULL, NULL, NULL, 1, NULL), (4, 0, NULL, '2023-01-01', 1, NULL), (1, NULL, 1, '2023-01-02', NULL, NULL), (8, 0, NULL, NULL, 1, NULL), (10, NULL, 0, '2023-01-01', 1, 1), (4, 0, NULL, NULL, 1, 1), (2, 1, 0, '2023-01-02', 1, NULL), (6, NULL, 1, '2023-01-02', 1, 1), (0, 0, NULL, '2023-01-02', NULL, 1), (8, 0, 0, '2023-01-01', NULL, 1), (1, 0, NULL, NULL, 1, NULL), (10, NULL, 1, '2023-01-02', 1, 1), (4, NULL, 0, '2023-01-02', 1, 1), (5, NULL, NULL, '2023-01-02', 1, NULL), (8, NULL, 1, '2023-01-01', 1, 1), (4, NULL, 1, NULL, 1, 1), (0, 1, 0, NULL, 1, NULL), (9, 1, 0, NULL, NULL, NULL), (9, NULL, 1, '2023-01-01', 1, 1), (11, 1, 0, NULL, 1, NULL), (NULL, 1, NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.BUYER_ID FROM SALES AS C LEFT JOIN PRODUCT AS G ON C.PRODUCT_ID = G.PRODUCT_ID LEFT JOIN (SELECT BUYER_ID, PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone') AS D ON C.BUYER_ID = D.BUYER_ID WHERE D.PRODUCT_NAME IS NULL AND G.PRODUCT_NAME = 'S8';

/*
Prediction Result:
(None,)
*/