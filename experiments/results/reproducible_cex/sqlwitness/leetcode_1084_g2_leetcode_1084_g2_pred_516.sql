-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-03-31', NULL), (1, '2019-01-01', 1), (0, '2019-03-31', 1), (2, 'default2', NULL), (3, 'default1', NULL), (4, 'default2', NULL), (5, '2019-03-31', NULL), (6, '2019-01-01', NULL), (7, '2019-4-1', 1), (8, '2018-12-31', 1), (9, '2019-4-1', 1), (10, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 1, '2019-01-02', NULL, 1), (NULL, NULL, -1, '2019-03-31', NULL, 1), (10, 1, 0, '2019-04-01', NULL, NULL), (10, 0, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-04-1' AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE <= '2018-12-31') AND NOT S.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-4-1') GROUP BY S.PRODUCT_ID;

/*
Prediction Result:
(None, None)
(0, '2019-03-31')
(10, 'default2')
*/