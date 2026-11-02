-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'S8', 1), (1, 'S8', 1), (2, 'S8', 1), (3, NULL, NULL), (4, NULL, NULL), (5, '%S8%', 1), (6, '%IPHONE%', 1), (7, '%S8%', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 0, NULL, NULL, 1), (1, 0, 1, NULL, NULL, NULL), (2, 1, 1, '2023-01-01', NULL, NULL), (3, 1, NULL, '2023-01-02', NULL, NULL), (0, NULL, 1, '2023-01-01', 1, 1), (6, 1, 0, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT USING (PRODUCT_ID) GROUP BY BUYER_ID HAVING GROUP_CONCAT(PRODUCT_NAME) LIKE '%S8%' AND GROUP_CONCAT(PRODUCT_NAME) NOT LIKE '%IPHONE%';

/*
Prediction Result:
(1,)
*/