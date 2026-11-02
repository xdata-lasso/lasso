-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (2, 'S8', NULL), (0, 'default1', 1), (-1, 'default2', NULL), (3, 'default1', 2), (4, 'S8', NULL), (5, 'default1', NULL), (6, 'default1', NULL), (7, NULL, 2), (8, 'default1', 2), (9, 'iPhone', 1), (10, 'iPhone', NULL), (11, 'S8', 2), (12, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, 1, '2023-01-01', 1, NULL), (11, -1, 0, '2023-01-01', 2, NULL), (3, NULL, NULL, NULL, 1, 2), (NULL, -1, 1, NULL, 2, 2), (3, NULL, NULL, NULL, 1, 2), (10, NULL, 2, '2023-01-01', NULL, NULL), (4, 2, 2, '2023-01-01', 2, NULL), (3, 2, 1, '2023-01-02', NULL, 2), (12, NULL, 1, '2023-01-02', NULL, NULL), (5, 1, 0, '2023-01-01', 1, 1), (-1, NULL, -1, '2023-01-02', NULL, 1), (2, 2, NULL, NULL, 2, 1), (4, 1, NULL, '2023-01-01', 2, 1), (5, 1, -1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES AS SLS JOIN PRODUCT AS PRD ON SLS.PRODUCT_ID = PRD.PRODUCT_ID GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'S8') >= 1 AND SUM(PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(0,)
*/