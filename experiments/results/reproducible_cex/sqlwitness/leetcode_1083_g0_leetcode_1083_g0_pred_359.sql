-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, 'default1', 1), (2, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, NULL, 1, 1), (0, 0, 0, '2023-01-02', 1, NULL), (2, 1, NULL, NULL, NULL, 1), (0, 0, 0, '2023-01-02', NULL, 1), (2, 1, 0, '2023-01-02', 1, NULL), (2, 1, NULL, NULL, NULL, 1);
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
WITH T_BP AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) SELECT DISTINCT T1.BUYER_ID FROM T_BP AS T1 WHERE EXISTS(SELECT * FROM T_BP AS T2 WHERE T1.BUYER_ID = T2.BUYER_ID AND T2.PRODUCT_NAME = 'S8') AND NOT EXISTS(SELECT * FROM T_BP AS T2 WHERE T1.BUYER_ID = T2.BUYER_ID AND T2.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
(0,)
*/