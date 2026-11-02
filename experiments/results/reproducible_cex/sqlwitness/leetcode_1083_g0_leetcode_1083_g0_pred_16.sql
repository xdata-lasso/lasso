-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 1), (0, 'S8', 2), (1, 'S8', 2), (-1, 'default1', NULL), (3, 'S8', NULL), (4, 'default2', NULL), (5, NULL, 1), (6, 'iPhone', NULL), (7, 'default2', 1), (8, NULL, 2), (9, NULL, 2), (10, 'default2', 2), (11, 'default2', 1), (12, 'S8', 2), (13, 'S8', NULL), (14, 'S8', 2), (15, 'iPhone', NULL), (16, 'iPhone', 2), (17, 'default2', 1), (18, 'default1', NULL), (19, 'S8', 2), (20, 'S8', 1), (21, 'iPhone', 2), (22, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, 2, '2023-01-01', 2, 2), (20, 1, NULL, '2023-01-01', NULL, 1), (16, 2, NULL, NULL, NULL, 1), (9, -1, 1, '2023-01-02', 1, 2), (9, NULL, 0, '2023-01-02', 2, NULL), (21, 0, NULL, '2023-01-02', NULL, 1), (21, -1, -1, '2023-01-02', 1, 1), (7, -1, 0, NULL, 2, NULL), (0, -1, 2, '2023-01-02', 2, 1), (1, 1, -1, '2023-01-02', NULL, 1), (10, NULL, 1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY BUYER_ID HAVING SUM(IIF(PRODUCT_NAME = 'S8', 1, 0)) > 0 AND SUM(IIF(PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(2,)
*/