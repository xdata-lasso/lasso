-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'S8', 2), (-1, 'default2', NULL), (2, 'default1', NULL), (3, 'iPhone', 1), (4, 'S8', 2), (5, 'iPhone', 1), (6, NULL, 2), (7, 'default2', 2), (8, 'default2', NULL), (9, 'S8', NULL), (10, NULL, 1), (11, 'default2', 2), (12, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, 1, '2023-01-02', NULL, 1), (8, NULL, NULL, '2023-01-01', NULL, 2), (0, 0, 2, '2023-01-02', NULL, 2), (2, 1, -1, '2023-01-01', NULL, 2), (2, 2, NULL, NULL, NULL, 1), (3, 1, 1, '2023-01-01', NULL, NULL), (3, 1, 0, '2023-01-01', 2, 1), (9, 2, 1, '2023-01-01', NULL, NULL), (6, NULL, 2, '2023-01-02', 2, 1), (10, -1, 2, '2023-01-02', 1, 1), (9, 2, 2, NULL, 2, 2), (4, -1, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT BUYER_ID FROM PRODUCT AS A1 JOIN SALES AS A2 ON A1.PRODUCT_ID = A2.PRODUCT_ID GROUP BY 1 HAVING SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None,)
(2,)
*/