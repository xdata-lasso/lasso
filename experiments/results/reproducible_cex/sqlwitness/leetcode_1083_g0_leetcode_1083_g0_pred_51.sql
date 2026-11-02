-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (2, 'default2', NULL), (-1, 'iPhone', 1), (1, 'S8', NULL), (3, 'iPhone', 1), (4, 'default1', 2), (5, 'default1', 1), (6, NULL, 2), (7, 'iPhone', NULL), (8, 'default2', 2), (9, 'default2', NULL), (10, NULL, NULL), (11, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, -1, 0, '2023-01-02', 1, 2), (3, 1, 1, '2023-01-02', 1, 2), (4, 2, 0, NULL, NULL, 1), (1, NULL, -1, NULL, 1, 2), (8, -1, 2, NULL, 1, 1), (NULL, 0, 0, NULL, NULL, 1), (6, -1, NULL, '2023-01-02', 2, 2), (7, NULL, NULL, '2023-01-01', NULL, 2), (8, 2, 1, '2023-01-01', NULL, 2), (0, -1, 0, '2023-01-02', 1, 1), (10, NULL, NULL, '2023-01-01', 2, 2), (6, 0, 1, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID) GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(-1,)
*/