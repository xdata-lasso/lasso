-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 1), (2, 'S8', 1), (1, NULL, 2), (0, 'iPhone', 1), (3, 'default2', NULL), (4, 'S8', 2), (5, 'iPhone', NULL), (6, 'iPhone', 2), (7, 'S8', 2), (8, NULL, 1), (9, 'iPhone', 2), (10, 'S8', 1), (11, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 2, NULL, NULL, NULL, 2), (3, 2, 1, '2023-01-02', NULL, 1), (6, 2, -1, NULL, 1, 1), (9, 0, -1, NULL, 1, NULL), (9, 1, -1, '2023-01-02', 2, 1), (7, -1, 0, '2023-01-01', 1, 2), (3, 0, -1, NULL, 2, 2), (7, 1, 0, '2023-01-01', 2, 2), (5, 2, NULL, '2023-01-01', NULL, 1), (NULL, 1, 1, '2023-01-02', 2, 1), (7, -1, 1, '2023-01-01', 1, 2), (7, 0, 1, NULL, 1, NULL), (7, 1, 2, '2023-01-01', 2, 1), (10, -1, 2, NULL, NULL, 1), (10, 1, 0, NULL, 2, NULL), (-1, 0, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME IN ('S8', 'iPhone')) GROUP BY BUYER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(0,)
(1,)
(2,)
*/