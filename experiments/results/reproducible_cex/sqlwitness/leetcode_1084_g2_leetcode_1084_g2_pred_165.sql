-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', NULL), (0, '2019-03-31', 1), (1, 'default1', 1), (2, '2019-01-01', NULL), (3, '2019-03-31', NULL), (4, NULL, NULL), (5, 'default1', 1), (6, 'default2', 1), (7, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, -1, '2019-04-01', 1, 1), (7, -1, NULL, '2019-01-01', NULL, NULL), (NULL, 1, 1, '2019-03-31', NULL, 1), (NULL, 0, NULL, '2019-04-01', NULL, NULL), (3, -1, 1, '2019-01-02', 1, NULL), (5, -1, 1, '2019-03-31', 1, 1), (4, -1, 1, '2019-04-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(3, '2019-03-31')
(5, 'default1')
(7, 'default1')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE >= '2019-01-01' AND S.SALE_DATE <= '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/