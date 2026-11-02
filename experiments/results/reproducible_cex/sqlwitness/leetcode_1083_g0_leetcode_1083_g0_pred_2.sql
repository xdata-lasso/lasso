-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'S8', 1), (2, 'S8', NULL), (3, 'iPhone', 1), (4, 'iPhone', NULL), (5, 'S8', NULL), (6, 'S8', NULL), (7, 'S8', NULL), (8, NULL, NULL), (9, 'default2', 1), (10, 'S8', 1), (11, NULL, NULL), (12, 'default1', NULL), (13, 'default1', NULL), (14, 'default2', NULL), (15, 'iPhone', 1), (16, 'default2', 1), (17, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 0, NULL, 1, 1), (0, NULL, 1, NULL, 1, NULL), (10, 1, NULL, '2023-01-02', NULL, NULL), (0, NULL, NULL, '2023-01-02', 1, NULL), (9, 1, 0, NULL, 1, NULL), (4, NULL, 1, '2023-01-02', 1, 1), (8, NULL, 1, NULL, 1, 1), (1, 1, NULL, '2023-01-02', 1, 1), (14, NULL, 0, '2023-01-01', 1, NULL), (11, 1, 0, '2023-01-01', NULL, NULL), (7, 1, 0, '2023-01-02', 1, 1), (12, NULL, 0, '2023-01-02', 1, 1), (11, NULL, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT A.BUYER_ID FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8') AS A LEFT JOIN (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'iPhone') AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.PRODUCT_NAME IS NULL;

/*
Prediction Result:
(0,)
(None,)
*/