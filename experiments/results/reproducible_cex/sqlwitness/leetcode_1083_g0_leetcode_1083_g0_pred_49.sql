-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (2, 'iPhone', 1), (-1, 'iPhone', 1), (0, 'default2', 1), (3, 'S8', NULL), (4, 'S8', 1), (5, 'default1', NULL), (6, NULL, 1), (7, 'S8', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, 1, 2, '2023-01-02', 2, 2), (3, 1, 1, NULL, 1, NULL), (3, -1, NULL, '2023-01-02', 1, NULL), (6, 1, 1, '2023-01-02', NULL, 1), (2, 1, NULL, '2023-01-02', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING SUM(CASE WHEN PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(1,)
*/