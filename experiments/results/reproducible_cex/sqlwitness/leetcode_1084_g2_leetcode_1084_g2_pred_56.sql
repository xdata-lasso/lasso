-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default2', 2), (1, NULL, NULL), (3, '2019-03-31', NULL), (0, 'default1', 2), (2, '2019-03-31', 1), (4, '2019-01-01', 1), (5, 'default1', 3), (6, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 3, 2, '2019-03-30', NULL, 3), (-1, 0, 2, NULL, 3, 2), (6, 1, NULL, '2023-01-02', 3, 2), (-1, 0, 3, '2019-03-31', NULL, 3), (3, NULL, -1, '2019-03-31', 3, 3), (NULL, 2, 0, '2023-01-02', NULL, NULL), (4, 2, 1, '2019-04-01', 2, NULL), (NULL, NULL, 0, '2018-12-31', 1, 2), (0, 2, NULL, '2019-01-01', 3, 2), (0, NULL, -1, '2019-01-02', 2, 2), (1, 3, 1, '2023-01-02', 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, 'default2')
(0, 'default1')
(3, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/