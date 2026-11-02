-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', NULL), (1, 'S8', 2), (2, 'default2', NULL), (0, 'default1', NULL), (3, 'iPhone', NULL), (4, 'default2', 2), (5, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, 0, '2023-01-01', 2, NULL), (2, 1, 0, '2023-01-01', 2, 2), (2, 2, 0, '2023-01-01', 2, NULL), (5, 1, 0, '2023-01-02', NULL, 1), (2, -1, 0, '2023-01-02', 1, 1), (5, NULL, 0, '2023-01-02', NULL, 2), (5, NULL, 2, '2023-01-02', 2, NULL), (3, 1, -1, '2023-01-02', 2, 1), (NULL, 0, 1, NULL, NULL, 2), (5, 1, NULL, '2023-01-01', NULL, 2), (0, -1, 2, NULL, 1, 2), (5, 1, -1, NULL, NULL, NULL), (5, NULL, 0, '2023-01-01', 1, 2), (3, 1, 1, '2023-01-01', 1, 1), (1, 1, -1, '2023-01-02', NULL, NULL), (3, 2, -1, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(2,)
*/

-- Prediction Query
WITH S AS (SELECT BUYER_ID, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8_CNT, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE_CNT FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY 1) SELECT BUYER_ID FROM S WHERE S8_CNT > 0 AND IPHONE_CNT = 0;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/