-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 1), (0, 'S8', NULL), (2, 'S8', NULL), (3, NULL, NULL), (4, 'default1', NULL), (5, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, 0, '2023-01-02', 1, 1), (2, 1, 1, '2023-01-01', NULL, 1), (2, 0, 0, '2023-01-01', 1, NULL), (0, 0, NULL, '2023-01-02', NULL, 1), (3, NULL, NULL, NULL, NULL, NULL), (5, NULL, 0, NULL, NULL, NULL), (1, 0, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'S8') AND NOT S.BUYER_ID IN (SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID = ((SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME = 'iPhone')));

/*
Prediction Result:
*/