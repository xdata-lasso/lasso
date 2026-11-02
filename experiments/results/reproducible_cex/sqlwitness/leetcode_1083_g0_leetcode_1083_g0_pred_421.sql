-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'S8', 1), (2, 'default2', NULL), (3, NULL, 1), (4, 'default2', 1), (5, 'default2', 1), (6, 'default1', 1), (7, 'default1', NULL), (8, 'S8', NULL), (9, 'iPhone', NULL), (10, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 0, 1, '2023-01-02', 1, 1), (3, 1, NULL, '2023-01-01', NULL, NULL), (9, 1, 0, '2023-01-02', 1, 1), (1, 1, NULL, '2023-01-01', 1, NULL), (4, NULL, 1, '2023-01-01', 1, NULL), (0, 0, 0, '2023-01-02', 1, NULL), (9, 0, 0, '2023-01-01', NULL, 1), (1, 0, 0, '2023-01-02', 1, NULL), (6, 0, 1, NULL, NULL, 1), (10, 1, 0, NULL, 1, 1), (4, 1, NULL, '2023-01-01', NULL, 1), (10, 0, 0, '2023-01-02', NULL, NULL), (0, 0, 1, '2023-01-02', NULL, 1), (10, 1, NULL, '2023-01-02', 1, 1), (6, 1, 0, '2023-01-01', 1, 1), (9, NULL, NULL, '2023-01-02', 1, 1), (NULL, 0, 1, NULL, 1, 1), (9, 1, 0, '2023-01-02', NULL, 1), (4, NULL, 0, NULL, 1, NULL), (4, NULL, 1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT A.BUYER_ID FROM (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) AS A LEFT JOIN (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) AS B ON A.BUYER_ID = B.BUYER_ID WHERE B.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/