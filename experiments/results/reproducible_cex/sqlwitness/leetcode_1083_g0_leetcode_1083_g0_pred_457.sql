-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'iPhone', 2), (0, NULL, 2), (2, 'S8', 2), (3, 'default1', 1), (4, NULL, NULL), (5, 'iPhone', 1), (6, 'S8', 2), (7, 'default2', NULL), (8, 'default1', NULL), (9, 'default2', 1), (10, 'S8', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 1, '2023-01-01', 2, 1), (0, 2, 0, '2023-01-02', 1, 1), (0, 1, 2, '2023-01-02', 1, NULL), (8, 1, 0, NULL, 2, NULL), (0, 0, 0, NULL, 2, NULL), (5, 2, 0, '2023-01-01', NULL, NULL), (5, 0, 1, '2023-01-01', 2, 1), (10, NULL, NULL, '2023-01-02', 1, 1), (NULL, NULL, 1, '2023-01-01', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT EXISTS(SELECT 1 FROM SALES AS S2 INNER JOIN PRODUCT AS P2 ON P2.PRODUCT_ID = S2.PRODUCT_ID WHERE P2.PRODUCT_NAME = 'iPhone' AND S2.BUYER_ID = S.BUYER_ID);

/*
Prediction Result:
(None,)
*/