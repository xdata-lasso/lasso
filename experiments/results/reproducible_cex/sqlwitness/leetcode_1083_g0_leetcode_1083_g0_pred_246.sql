-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'S8', 1), (0, 'default2', NULL), (2, 'iPhone', 2), (-1, 'S8', 1), (3, 'default2', 2), (4, 'default1', 2), (5, 'S8', 2), (6, 'iPhone', NULL), (7, 'default2', NULL), (8, 'default2', 1), (9, 'S8', NULL), (10, 'default1', 1), (11, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 2, NULL, NULL, NULL, 1), (5, NULL, -1, '2023-01-01', 1, 2), (8, 1, NULL, '2023-01-02', NULL, 2), (-1, -1, 1, '2023-01-02', NULL, 1), (6, 1, 0, '2023-01-01', 2, 2), (7, 0, NULL, NULL, 2, NULL), (0, 1, 2, '2023-01-01', NULL, 1), (4, 2, NULL, NULL, NULL, 1), (1, 2, 1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(-1,)
(1,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') >= 1 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(-1,)
(1,)
*/