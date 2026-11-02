-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, NULL, NULL), (2, 'default2', 1), (3, 'default1', 1), (4, 'default2', 1), (5, NULL, 1), (6, 'default2', 1), (7, 'S8', 1), (8, 'S8', 1), (9, NULL, NULL), (10, 'default2', 1), (11, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, 0, NULL, NULL, NULL), (8, 1, NULL, NULL, 1, NULL), (6, 1, NULL, '2023-01-01', 1, 1), (4, 1, 1, '2023-01-02', NULL, NULL), (8, 1, NULL, '2023-01-01', NULL, NULL), (10, 0, 0, '2023-01-02', NULL, NULL), (1, 1, 1, '2023-01-01', 1, 1), (4, 0, 1, NULL, 1, NULL), (6, 1, NULL, NULL, 1, NULL), (1, 1, 0, '2023-01-02', NULL, 1), (4, 1, 0, '2023-01-02', 1, NULL), (NULL, 0, 1, NULL, NULL, NULL), (1, NULL, NULL, '2023-01-01', 1, 1), (2, NULL, 0, NULL, 1, 1), (8, NULL, NULL, '2023-01-01', 1, 1), (5, 1, 1, '2023-01-02', 1, 1), (7, 0, 1, '2023-01-01', 1, 1), (7, 0, 1, NULL, 1, NULL), (9, NULL, NULL, '2023-01-02', NULL, NULL), (9, 0, 0, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(1,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE BUYER_ID IN (SELECT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
(1,)
*/