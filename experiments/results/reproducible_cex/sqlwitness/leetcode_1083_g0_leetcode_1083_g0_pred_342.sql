-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, 'S8', 1), (2, 'S8', 1), (3, 'default1', NULL), (4, 'S8', NULL), (5, 'S8', 1), (6, 'default1', 1), (7, 'S8', 1), (8, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 0, '2023-01-01', NULL, NULL), (3, 0, 0, '2023-01-02', 1, 1), (NULL, 0, NULL, NULL, NULL, 1), (4, 1, 1, '2023-01-02', 1, NULL), (2, NULL, 0, NULL, 1, 1), (4, 0, 1, '2023-01-02', NULL, NULL), (8, 0, 0, NULL, NULL, NULL), (0, NULL, 1, NULL, 1, NULL), (0, NULL, 0, NULL, 1, 1), (7, 0, NULL, '2023-01-01', 1, 1), (2, 1, 1, NULL, NULL, NULL), (8, 1, NULL, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
(0,)
(None,)
*/

-- Prediction Query
WITH A AS (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8') SELECT DISTINCT BUYER_ID FROM A WHERE NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone') ORDER BY BUYER_ID;

/*
Prediction Result:
(None,)
(0,)
(1,)
*/