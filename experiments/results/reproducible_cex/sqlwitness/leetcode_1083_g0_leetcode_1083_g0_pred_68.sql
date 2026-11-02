-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'S8', 2), (1, 'default1', 2), (-1, 'iPhone', 1), (0, 'S8', 2), (3, 'iPhone', NULL), (4, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 2, '2023-01-02', 2, NULL), (1, 0, 2, '2023-01-01', NULL, NULL), (4, 0, 2, '2023-01-02', NULL, 2), (3, 1, NULL, NULL, NULL, NULL), (2, 2, 2, '2023-01-01', 1, 1), (2, -1, 2, '2023-01-02', 2, 1), (3, 2, NULL, '2023-01-02', 2, 2), (1, NULL, NULL, '2023-01-02', 1, 2), (1, NULL, 2, NULL, 2, NULL), (NULL, 0, 0, '2023-01-01', 2, 1), (4, NULL, 0, '2023-01-02', 2, 2), (-1, 2, -1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SALES.BUYER_ID AS BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT SALES.BUYER_ID IN (SELECT SALES.BUYER_ID FROM PRODUCT INNER JOIN SALES ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.BUYER_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.BUYER_ID HAVING SUM(P.PRODUCT_NAME = 'S8') >= 1 AND SUM(P.PRODUCT_NAME = 'iPhone') = 0;

/*
Prediction Result:
(2,)
*/