-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'G4', 1), (0, 'iPhone', 1), (1, 'default2', NULL), (2, 'iPhone', 1), (3, 'default2', 1), (4, 'default1', NULL), (5, 'S8', NULL), (6, 'default2', NULL), (7, NULL, NULL), (8, 'S8', NULL), (9, 'default1', 1), (10, 'G4', 1), (11, 'G4', 1), (12, 'S8', 1), (13, 'S8', NULL), (14, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, -1, 0, '2023-01-01', 1, NULL), (10, NULL, NULL, '2023-01-01', NULL, 1), (8, NULL, NULL, '2023-01-01', 1, 1), (13, 1, 0, '2023-01-01', NULL, 1), (5, 0, -1, NULL, 1, NULL), (4, NULL, NULL, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
(None,)
(-1,)
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') > 0 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0 AND SUM(P.PRODUCT_NAME = 'G4') = 0;

/*
Prediction Result:
(-1,)
(0,)
*/