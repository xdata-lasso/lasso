-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'S8', 1), (2, 'default1', NULL), (3, 'default2', 1), (4, NULL, 1), (5, 'iPhone', 1), (6, 'S8', NULL), (7, 'default1', NULL), (8, NULL, NULL), (9, 'default1', NULL), (10, 'iPhone', 1), (11, 'default1', 1), (12, 'default2', 1), (13, 'S8', NULL), (14, NULL, NULL), (15, NULL, 1), (16, 'S8', 1), (17, 'iPhone', 1), (18, 'iPhone', NULL), (19, 'default2', 1), (20, 'S8', NULL), (21, 'default1', 1), (22, 'iPhone', NULL), (23, 'default2', 1), (24, 'S8', NULL), (25, 'S8', NULL), (26, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (25, NULL, 0, '2023-01-01', 1, 1), (22, 1, 1, NULL, NULL, 1), (25, 1, 0, '2023-01-01', 1, NULL), (12, NULL, 0, '2023-01-01', 1, 1), (11, 0, NULL, NULL, 1, NULL), (5, 1, 1, '2023-01-02', 1, 1), (9, NULL, 1, NULL, NULL, 1), (1, 0, 0, '2023-01-01', NULL, NULL), (0, NULL, 1, '2023-01-01', 1, NULL), (6, NULL, NULL, '2023-01-01', NULL, 1), (5, 0, 0, '2023-01-01', NULL, NULL), (24, 0, 1, '2023-01-02', NULL, 1), (10, 0, NULL, '2023-01-01', NULL, 1), (2, 1, 0, NULL, NULL, NULL), (21, 0, NULL, '2023-01-02', 1, NULL), (21, 0, 1, NULL, NULL, NULL), (4, 0, 0, '2023-01-02', 1, NULL), (25, NULL, 1, '2023-01-02', 1, 1), (17, 0, 0, '2023-01-01', NULL, 1), (25, 0, 0, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM (SELECT S.PRODUCT_ID, PRODUCT_NAME, BUYER_ID FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8') AS S LEFT JOIN (SELECT S.PRODUCT_ID, PRODUCT_NAME, BUYER_ID FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone') AS I USING (BUYER_ID) WHERE I.BUYER_ID IS NULL;

/*
Prediction Result:
(None,)
*/