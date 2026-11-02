-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', NULL), (1, 'default1', 1), (-1, 'S8', 2), (0, 'default2', 2), (3, 'default2', 2), (4, 'default2', NULL), (5, 'S8', NULL), (6, 'default2', 2), (7, 'default2', 2), (8, 'iPhone', 1), (9, NULL, NULL), (10, NULL, 1), (11, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, 0, '2023-01-02', 2, 1), (11, 2, -1, '2023-01-02', NULL, NULL), (7, NULL, -1, '2023-01-01', NULL, 2), (3, NULL, 1, '2023-01-01', NULL, NULL), (3, -1, 2, '2023-01-02', 1, NULL), (5, 0, 2, NULL, NULL, 1), (4, 2, -1, NULL, 2, NULL), (-1, NULL, NULL, '2023-01-01', NULL, 2), (4, 0, -1, '2023-01-02', NULL, 2), (8, 0, -1, '2023-01-01', 1, 1), (9, NULL, 2, '2023-01-02', NULL, NULL), (4, NULL, NULL, NULL, 1, 1), (9, NULL, 2, '2023-01-01', NULL, 2), (NULL, 0, 1, '2023-01-02', 1, 1), (10, NULL, NULL, NULL, 1, 2), (-1, 1, 0, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(2,)
(0,)
*/

-- Prediction Query
SELECT BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(IIF(P.PRODUCT_NAME = 'S8', 1, 0)) > 0 AND SUM(IIF(P.PRODUCT_NAME = 'iPhone', 1, 0)) = 0;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/