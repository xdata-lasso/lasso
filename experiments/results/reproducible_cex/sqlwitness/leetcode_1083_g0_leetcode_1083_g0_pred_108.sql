-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'S8', 1), (2, NULL, NULL), (3, 'S8', NULL), (4, 'iPhone', 1), (5, 'default1', NULL), (6, 'S8', 1), (7, 'default2', NULL), (8, 'default2', 2), (9, 'default2', 2), (10, NULL, NULL), (11, 'S8', 1), (12, 'iPhone', 1), (13, NULL, 2), (14, 'S8', 2), (15, 'iPhone', NULL), (16, 'default1', 2), (17, 'S8', 1), (18, 'S8', 1), (19, 'S8', 1), (20, 'default1', 2), (21, NULL, 2), (22, 'S8', NULL), (23, NULL, 2), (24, 'S8', NULL), (25, NULL, 1), (26, 'iPhone', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (22, 0, NULL, NULL, NULL, 1), (11, 0, 1, '2023-01-01', 2, NULL), (14, NULL, NULL, '2023-01-02', 2, 2), (21, 0, 1, '2023-01-02', 2, NULL), (0, 2, 0, NULL, 2, NULL), (4, 1, 0, NULL, NULL, 2), (20, 1, NULL, '2023-01-01', NULL, 1), (6, 0, 1, '2023-01-01', 2, 1), (21, NULL, 1, '2023-01-01', 2, 2), (0, 0, 1, '2023-01-01', NULL, 1), (3, 1, NULL, NULL, 1, 1), (19, 2, 2, '2023-01-01', 1, 1), (19, 1, 1, '2023-01-02', 2, 1), (21, 2, 0, '2023-01-02', NULL, 1), (12, 0, NULL, NULL, 2, NULL), (20, 2, 2, NULL, 2, 1), (3, 1, 1, '2023-01-01', 2, 1), (19, NULL, 1, '2023-01-01', 2, 1), (2, 0, 0, NULL, NULL, NULL), (25, NULL, 1, NULL, NULL, 1), (9, 2, 0, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE P.PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')) GROUP BY 1;

/*
Prediction Result:
(1,)
(2,)
*/