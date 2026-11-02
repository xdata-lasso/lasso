-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'iPhone', 1), (2, 'S8', NULL), (3, NULL, 1), (4, 'iPhone', 1), (5, NULL, NULL), (6, 'S8', 1), (7, 'default1', NULL), (8, 'default1', NULL), (9, 'iPhone', 1), (10, NULL, 1), (11, NULL, NULL), (12, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 0, 0, NULL, NULL, 1), (NULL, 0, 1, '2023-01-01', 1, 1), (11, NULL, 0, '2023-01-01', NULL, NULL), (1, 0, NULL, '2023-01-02', 1, NULL), (4, NULL, NULL, NULL, 1, NULL), (8, 0, 1, '2023-01-02', NULL, NULL), (4, 0, 0, '2023-01-02', NULL, 1), (12, 1, 1, NULL, 1, NULL), (12, NULL, 1, NULL, NULL, NULL), (2, 1, 1, '2023-01-01', NULL, 1), (11, NULL, 0, NULL, NULL, 1), (11, 0, 1, '2023-01-02', NULL, NULL), (2, 1, 0, '2023-01-02', 1, NULL), (5, 1, 0, '2023-01-01', NULL, 1), (2, 0, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8')) AS T WHERE NOT T.BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone'));

/*
Prediction Result:
(1,)
(0,)
*/