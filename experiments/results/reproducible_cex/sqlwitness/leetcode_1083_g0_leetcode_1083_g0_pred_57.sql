-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (2, 'S8', NULL), (-1, 'S8', NULL), (1, NULL, 1), (3, NULL, 2), (4, NULL, NULL), (5, 'default1', 2), (6, 'iPhone', NULL), (7, 'default1', 1), (8, 'iPhone', 1), (9, 'default2', 1), (10, 'iPhone', NULL), (11, 'default2', 2), (12, 'default2', 2), (13, 'iPhone', 2), (14, 'iPhone', NULL), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, 0, 0, '2023-01-01', 1, 2), (10, 0, 2, '2023-01-01', 2, NULL), (NULL, -1, -1, '2023-01-01', NULL, 1), (10, -1, 0, NULL, NULL, 2), (2, 1, NULL, '2023-01-01', 2, 2), (9, 1, 2, '2023-01-02', 1, 1), (5, 0, 0, '2023-01-01', 1, 2), (6, 1, 2, NULL, 1, 2), (2, NULL, -1, '2023-01-01', NULL, 1), (0, -1, NULL, '2023-01-01', 2, 1), (10, NULL, -1, NULL, NULL, 2), (5, 0, 2, NULL, 2, 2), (6, 0, 1, '2023-01-01', 1, NULL), (9, -1, 0, '2023-01-02', 1, 2), (3, NULL, 2, '2023-01-01', NULL, NULL), (4, -1, NULL, NULL, 2, NULL), (NULL, 1, -1, NULL, 1, 2), (6, 2, 0, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY 1 HAVING MAX(PRODUCT_NAME = 'S8') AND MAX(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
*/