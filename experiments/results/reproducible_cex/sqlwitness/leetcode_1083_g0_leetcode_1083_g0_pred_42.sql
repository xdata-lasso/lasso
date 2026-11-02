-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'S8', 1), (0, 'default1', NULL), (1, 'S8', 1), (2, 'default1', NULL), (3, 'S8', 1), (4, 'iPhone', 1), (5, NULL, 1), (6, 'default2', NULL), (7, 'S8', NULL), (8, 'iPhone', NULL), (9, 'S8', 1), (10, 'S8', NULL), (11, 'default2', NULL), (12, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, 1, '2023-01-02', 1, NULL), (8, 0, 0, NULL, NULL, 1), (5, NULL, 0, NULL, 1, NULL), (1, 0, NULL, '2023-01-01', NULL, 1), (3, -1, 1, '2023-01-01', NULL, NULL), (NULL, NULL, -1, NULL, NULL, NULL), (5, NULL, 0, '2023-01-01', NULL, 1), (0, -1, 1, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(1,)
*/