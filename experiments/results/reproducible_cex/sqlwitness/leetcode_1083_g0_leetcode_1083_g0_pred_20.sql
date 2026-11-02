-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', NULL), (0, 'default2', 1), (2, NULL, 1), (3, 'default2', 1), (4, 'default1', 1), (5, 'iPhone', NULL), (6, 'default1', 1), (7, 'iPhone', NULL), (8, 'default2', 1), (9, 'S8', NULL), (10, NULL, 1), (11, 'default1', NULL), (12, 'S8', NULL), (13, 'default2', 1), (14, 'default2', 1), (15, 'default1', 1), (16, 'default1', 1), (17, 'iPhone', 1), (18, NULL, NULL), (19, 'S8', NULL), (20, NULL, 1), (21, 'S8', NULL), (22, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 0, '2023-01-01', NULL, 1), (20, 1, NULL, '2023-01-01', NULL, NULL), (9, NULL, NULL, '2023-01-02', 1, NULL), (12, 1, 0, NULL, 1, NULL), (0, NULL, 1, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES INNER JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8') AND NOT BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES INNER JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone') ORDER BY BUYER_ID;

/*
Prediction Result:
(0,)
*/