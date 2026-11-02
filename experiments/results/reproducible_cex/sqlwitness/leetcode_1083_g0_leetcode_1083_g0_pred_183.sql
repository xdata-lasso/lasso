-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, 'iPhone', NULL), (2, 'default1', 1), (3, 'default1', 1), (4, NULL, 1), (5, 'iPhone', 1), (6, 'default2', NULL), (7, NULL, NULL), (8, 'S8', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, NULL, '2023-01-01', NULL, NULL), (2, 1, 0, NULL, NULL, NULL), (8, 1, NULL, '2023-01-02', 1, 1), (1, 0, 0, '2023-01-01', 1, 1), (3, 0, NULL, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT (B.BUYER_ID) FROM SALES AS B WHERE B.BUYER_ID IN (SELECT B.BUYER_ID FROM SALES AS B LEFT JOIN PRODUCT AS A ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME = 'S8') AND NOT B.BUYER_ID IN (SELECT B.BUYER_ID FROM SALES AS B LEFT JOIN PRODUCT AS A ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/