-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (0, 'default1', NULL), (-1, 'iPhone', 2), (2, NULL, NULL), (3, 'default2', 2), (4, 'default1', 2), (5, 'default2', 1), (6, 'iPhone', 2), (7, 'S8', 1), (8, 'default1', 1), (9, 'iPhone', 1), (10, 'S8', NULL), (11, 'iPhone', 2), (12, 'default1', 1), (13, 'default2', 1), (14, 'default2', NULL), (15, NULL, NULL), (16, 'iPhone', NULL), (17, 'default1', 1), (18, 'iPhone', 2), (19, 'S8', 2), (20, 'S8', NULL), (21, 'default2', NULL), (22, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, NULL, 1, '2023-01-01', 2, NULL), (2, 0, 1, '2023-01-02', 2, NULL), (21, 2, 0, '2023-01-01', NULL, 1), (19, NULL, NULL, '2023-01-02', 1, 1), (19, 1, 0, '2023-01-02', 1, 1), (0, 0, 0, '2023-01-02', 1, 1), (11, NULL, 0, NULL, 2, NULL), (14, 0, 0, '2023-01-02', 1, NULL), (7, 2, 1, NULL, 1, 2), (20, 1, -1, '2023-01-01', 2, NULL), (2, NULL, NULL, '2023-01-01', NULL, 1), (2, 1, 1, NULL, NULL, 2), (19, 2, 1, '2023-01-02', 2, NULL), (11, 0, 0, NULL, 1, 2), (20, 1, NULL, '2023-01-02', 1, NULL), (1, -1, NULL, '2023-01-01', 1, 1), (3, -1, 0, '2023-01-01', 2, 2), (6, NULL, 1, NULL, 1, NULL), (14, 1, -1, '2023-01-01', 2, NULL), (4, NULL, 2, NULL, NULL, 1), (4, -1, 0, '2023-01-02', 1, NULL), (16, 0, 1, '2023-01-01', 1, 2), (10, 1, 0, '2023-01-01', 2, NULL), (14, 2, 2, NULL, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8' OR PRODUCT_NAME = 'iPhone') GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(-1,)
*/