-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 1), (0, 'default2', 1), (-1, 'iPhone', 1), (1, 'default1', 2), (3, 'S8', NULL), (4, 'S8', NULL), (5, 'iPhone', NULL), (6, 'S8', 1), (7, 'iPhone', NULL), (8, 'default2', 2), (9, 'S8', 1), (10, 'S8', 1), (11, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, NULL, NULL, NULL, 1, NULL), (5, 2, 2, '2023-01-01', 1, 1), (2, -1, 1, '2023-01-01', 2, NULL), (9, -1, 2, '2023-01-01', NULL, 1), (9, NULL, 0, '2023-01-02', 1, NULL), (8, NULL, -1, '2023-01-01', 1, 2), (7, 0, 2, '2023-01-01', 2, 2), (6, 2, 1, NULL, 1, NULL), (1, NULL, 0, NULL, 2, NULL), (3, 0, 2, '2023-01-01', NULL, 1), (2, 1, NULL, '2023-01-02', 2, 1), (3, NULL, NULL, NULL, 1, 1), (10, 0, NULL, '2023-01-02', 2, 2), (5, -1, 1, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END) >= 1 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(None,)
(0,)
*/