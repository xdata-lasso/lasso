-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'iPhone', 1), (2, 'default2', 2), (0, 'S8', NULL), (1, 'default1', 2), (3, 'iPhone', 1), (4, 'default1', 1), (5, 'iPhone', 1), (6, 'S8', NULL), (7, 'default1', 2), (8, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 0, '2023-01-02', 1, 2), (-1, NULL, 0, '2023-01-02', 1, NULL), (1, 0, -1, NULL, 2, NULL), (5, 1, 0, '2023-01-01', 1, 1), (2, -1, 2, '2023-01-02', 1, 2), (0, NULL, -1, '2023-01-01', NULL, 2), (6, 0, NULL, NULL, NULL, 2), (6, -1, NULL, NULL, 1, NULL), (2, NULL, 0, '2023-01-02', 2, 1), (8, 2, 1, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(-1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME, SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS CNT_S8, SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS CNT_IPHONE FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' OR PRODUCT_NAME = 'iPhone' GROUP BY BUYER_ID) AS T WHERE CNT_S8 > 0 AND CNT_IPHONE = 0;

/*
Prediction Result:
(None,)
(-1,)
*/