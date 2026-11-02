-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 3), (-1, '2019-03-31', 3), (0, '2019-03-31', 2), (2, 'default1', 1), (3, 'default2', 2), (4, NULL, 3), (5, '2019-03-31', NULL), (6, 'default2', NULL), (7, 'default1', 1), (8, 'default2', NULL), (9, 'default2', NULL), (10, 'default1', 2), (11, 'default2', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 2, 2, '2019-04-01', 3, 3), (NULL, 2, 2, NULL, 2, 2), (5, 0, -1, NULL, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY 1, 2 HAVING SUM(CASE WHEN SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(5, '2019-03-31')
*/