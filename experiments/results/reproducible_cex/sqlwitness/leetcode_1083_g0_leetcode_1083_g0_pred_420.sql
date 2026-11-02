-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'G4', 1), (2, NULL, NULL), (0, 'S8', NULL), (1, 'S8', NULL), (3, 'S8', NULL), (4, 'iPhone', NULL), (5, 'iPhone', 1), (6, 'S8', 2), (7, 'default2', NULL), (8, 'default2', 2), (9, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 2, NULL, NULL, 2, 2), (8, -1, 2, '2023-01-01', 2, NULL), (6, 1, 0, '2023-01-01', NULL, 2), (0, 1, 2, '2023-01-01', 2, NULL), (6, 2, NULL, NULL, 1, 2), (3, -1, NULL, '2023-01-02', 1, 2), (8, -1, 1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT B.BUYER_ID FROM (SELECT A.BUYER_ID, SUM(CASE WHEN A.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) AS S8, SUM(CASE WHEN A.PRODUCT_NAME = 'G4' THEN 1 ELSE 0 END) AS G4, SUM(CASE WHEN A.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) AS IPHONE FROM (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID) AS A GROUP BY A.BUYER_ID) AS B WHERE B.S8 >= 1 AND B.IPHONE = 0;

/*
Prediction Result:
(0,)
(2,)
*/