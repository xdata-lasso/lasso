-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', NULL), (0, 'iPhone', NULL), (2, NULL, 1), (3, 'S8', 1), (4, 'S8', 1), (5, NULL, 1), (6, 'default2', NULL), (7, 'iPhone', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 0, '2023-01-02', 1, NULL), (4, NULL, 0, NULL, NULL, NULL), (3, 0, 1, '2023-01-01', NULL, 1), (1, NULL, 1, NULL, NULL, 1), (7, 1, NULL, '2023-01-02', NULL, 1), (4, NULL, NULL, '2023-01-01', 1, NULL), (NULL, 1, 1, '2023-01-01', 1, 1), (6, 0, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT SALES.BUYER_ID AS BUYER_IPHONE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone'), CTE1 AS (SELECT DISTINCT SALES.BUYER_ID AS BUYER_S8 FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8') SELECT CTE1.BUYER_S8 AS BUYER_ID FROM CTE1 LEFT JOIN CTE ON CTE.BUYER_IPHONE = CTE1.BUYER_S8 WHERE BUYER_IPHONE IS NULL;

/*
Prediction Result:
(0,)
(1,)
(None,)
*/