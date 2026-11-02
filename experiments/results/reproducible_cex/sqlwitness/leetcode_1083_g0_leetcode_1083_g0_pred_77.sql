-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 2), (0, 'default1', 1), (1, NULL, 3), (3, 'default1', 2), (4, 'S8', NULL), (5, 'default2', 2), (6, NULL, 2), (7, 'S8', NULL), (8, 'default2', NULL), (9, NULL, 3), (10, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (9, 2, NULL, '2023-01-01', NULL, 3), (NULL, NULL, 2, NULL, NULL, 2), (7, NULL, NULL, '2023-01-01', NULL, 2), (2, NULL, NULL, '2023-01-02', 3, 2), (3, 2, NULL, NULL, 3, 1), (3, 2, 3, '2023-01-02', NULL, 3), (4, 1, 0, '2023-01-02', 3, NULL), (0, NULL, 3, '2023-01-02', 3, 1), (0, NULL, 1, NULL, 1, NULL);
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
WITH BUYER AS (SELECT BUYER_ID, PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME IN ('iPhone', 'S8') GROUP BY 1, 2) SELECT DISTINCT T1.BUYER_ID FROM (SELECT BUYER_ID FROM BUYER WHERE PRODUCT_NAME = 'S8') AS T1 JOIN (SELECT BUYER_ID FROM BUYER GROUP BY 1 HAVING COUNT(*) = 1) AS T2 ON T1.BUYER_ID = T2.BUYER_ID;

/*
Prediction Result:
(0,)
*/