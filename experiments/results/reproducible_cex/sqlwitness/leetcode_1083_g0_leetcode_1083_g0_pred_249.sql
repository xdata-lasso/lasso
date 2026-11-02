-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (2, NULL, 1), (-1, 'S8', 2), (0, 'default2', 1), (3, 'default1', NULL), (4, 'iPhone', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, NULL, '2023-01-01', 1, NULL), (4, -1, 1, NULL, NULL, NULL), (3, NULL, 2, NULL, 1, NULL), (1, 0, 1, '2023-01-02', 2, 2), (3, NULL, 2, '2023-01-01', NULL, 1), (0, NULL, -1, '2023-01-01', 1, 2), (-1, 2, 2, '2023-01-01', NULL, NULL), (NULL, 1, 1, NULL, 1, NULL), (-1, NULL, NULL, '2023-01-01', 1, 1), (NULL, NULL, -1, '2023-01-02', 2, 2), (NULL, -1, NULL, '2023-01-02', NULL, 1), (2, 1, 0, '2023-01-01', 2, 2), (-1, -1, 0, NULL, 1, 2), (1, NULL, NULL, NULL, 1, 1);
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
SELECT DISTINCT A.BUYER_ID FROM (SELECT S.BUYER_ID, CASE WHEN P.PRODUCT_NAME = 'S8' THEN 1 ELSE 0 END AS S8FLG, CASE WHEN P.PRODUCT_NAME = 'iPhone' THEN 1 ELSE 0 END AS IPHONEFLG FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY BUYER_ID HAVING SUM(S8FLG) >= 1 AND SUM(IPHONEFLG) <= 0) AS A;

/*
Prediction Result:
(None,)
(0,)
(2,)
*/