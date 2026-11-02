-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'default1', NULL), (-1, 'iPhone', NULL), (2, 'default2', 2), (3, 'iPhone', NULL), (4, 'iPhone', NULL), (5, 'S8', 1), (6, 'S8', NULL), (7, 'default1', 1), (8, 'S8', 2), (9, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, -1, 2, '2023-01-01', 1, 1), (7, 1, 2, '2023-01-01', 1, NULL), (9, 1, NULL, '2023-01-01', 1, 2), (4, 1, 0, '2023-01-01', NULL, NULL), (5, 1, 2, '2023-01-01', NULL, 1), (NULL, NULL, 0, NULL, 1, NULL), (3, 1, NULL, '2023-01-02', 1, NULL), (1, NULL, 1, NULL, NULL, 2), (3, 2, NULL, '2023-01-02', 2, 2), (3, -1, NULL, '2023-01-02', 1, NULL), (7, 1, 2, NULL, NULL, 1), (5, -1, 1, '2023-01-01', NULL, NULL), (0, 0, 0, '2023-01-01', 1, 1), (1, -1, -1, '2023-01-02', 1, 2), (9, 1, -1, '2023-01-01', 1, 1), (7, -1, 0, '2023-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
WITH REFINED_PRODUCT AS (SELECT PRODUCT_ID, PRODUCT_NAME, CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END AS S8_SALE, CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END AS IPHONE_SALE FROM PRODUCT WHERE PRODUCT_NAME IN ('S8', 'iPhone')) SELECT BUYER_ID FROM SALES JOIN REFINED_PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(IPHONE_SALE) = 0 AND SUM(S8_SALE) > 0;

/*
Prediction Result:
(-1,)
(1,)
(2,)
*/