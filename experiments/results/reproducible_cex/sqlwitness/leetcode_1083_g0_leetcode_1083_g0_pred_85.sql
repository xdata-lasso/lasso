-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, 'S8', 1), (2, 'S8', 1), (3, NULL, NULL), (4, 'S8', NULL), (5, 'default2', NULL), (6, 'iPhone', NULL), (7, 'default1', NULL), (8, 'S8', NULL), (9, NULL, 1), (10, 'iPhone', 1), (11, 'default2', 1), (12, 'default1', 1), (13, 'iPhone', NULL), (14, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, NULL, 1, '2023-01-01', 1, NULL), (9, 0, 1, NULL, 1, NULL), (0, 0, 0, '2023-01-02', 1, NULL), (0, 1, NULL, '2023-01-02', NULL, 1), (5, NULL, NULL, '2023-01-01', NULL, NULL), (0, NULL, 1, '2023-01-01', NULL, NULL), (5, NULL, 0, NULL, 1, 1), (14, 0, 0, NULL, NULL, NULL), (4, 0, NULL, '2023-01-02', 1, 1), (4, 0, 0, '2023-01-01', NULL, 1), (6, 1, NULL, '2023-01-02', NULL, 1), (11, 0, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT * FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'S8'), T2 AS (SELECT * FROM SALES JOIN PRODUCT USING (PRODUCT_ID) WHERE PRODUCT_NAME = 'iPhone') SELECT DISTINCT T1.BUYER_ID FROM T1 LEFT JOIN T2 USING (BUYER_ID) WHERE T2.SELLER_ID IS NULL;

/*
Prediction Result:
(0,)
(None,)
(1,)
*/