-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'iPhone', 1), (2, NULL, 1), (3, 'S8', 1), (4, 'iPhone', NULL), (5, 'default1', NULL), (6, 'default1', NULL), (7, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, NULL, 1, '2023-01-01', NULL, NULL), (7, NULL, 1, NULL, 1, NULL), (6, NULL, NULL, NULL, 1, 1), (0, 0, NULL, '2023-01-01', 1, 1), (3, 1, NULL, '2023-01-01', NULL, 1), (3, 1, 1, '2023-01-01', NULL, 1), (7, 0, 1, '2023-01-01', NULL, 1), (4, NULL, 0, '2023-01-02', 1, 1), (7, 0, NULL, '2023-01-01', 1, 1), (5, 0, 1, NULL, NULL, 1), (NULL, 0, 1, '2023-01-01', 1, NULL), (NULL, 1, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT SS8.BUYER_ID FROM SALES AS SS8 INNER JOIN PRODUCT AS PS8 ON PS8.PRODUCT_ID = SS8.PRODUCT_ID AND PRODUCT_NAME = 'S8' LEFT JOIN (SELECT BUYER_ID, S.PRODUCT_ID FROM SALES AS S INNER JOIN PRODUCT AS PIPHONE ON PIPHONE.PRODUCT_ID = S.PRODUCT_ID AND PIPHONE.PRODUCT_NAME = 'iPhone') AS SIPHONE ON SS8.BUYER_ID = SIPHONE.BUYER_ID WHERE NOT PS8.PRODUCT_ID IS NULL AND SIPHONE.PRODUCT_ID IS NULL;

/*
Prediction Result:
(None,)
(1,)
*/