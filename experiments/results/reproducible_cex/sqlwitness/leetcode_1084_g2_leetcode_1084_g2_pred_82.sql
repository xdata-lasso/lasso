-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, 1), (1, '2019-01-01', NULL), (0, NULL, NULL), (2, '2019-03-31', 1), (3, '2019-03-31', NULL), (4, 'default1', NULL), (5, NULL, NULL), (6, 'default1', NULL), (7, '2019-03-31', 1), (8, '2019-03-31', 1), (9, '2019-01-01', NULL), (10, '2019-01-01', 1), (11, 'default2', NULL), (12, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 0, '2019-03-31', NULL, NULL), (NULL, 0, 1, '2023-01-02', 1, NULL), (1, 1, -1, '2023-01-02', NULL, NULL), (12, -1, NULL, '2019-03-30', NULL, NULL), (11, NULL, -1, '2023-01-02', NULL, NULL), (12, NULL, NULL, '2023-01-01', 1, 1), (NULL, -1, -1, '2019-03-30', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(10, '2019-01-01')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/