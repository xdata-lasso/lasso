-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 2), (2, 'default1', NULL), (0, 'default1', NULL), (3, 'default1', NULL), (4, '%IPHONE%', 1), (5, '%S8%', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 0, NULL, 1, 1), (5, 1, NULL, NULL, NULL, 2), (NULL, 0, 0, '2023-01-02', NULL, 1), (3, NULL, 1, NULL, 2, 1), (NULL, 0, 0, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM (SELECT BUYER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY 1) AS N WHERE LOWER(PRODUCTS) LIKE '%S8%' AND LOWER(PRODUCTS) NOT LIKE '%IPHONE%';

/*
Prediction Result:
(None,)
*/