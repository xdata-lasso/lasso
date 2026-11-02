-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 1, '2019-04-01', NULL, 2), (NULL, NULL, 0, '2019-01-02', NULL, 1), (2, 2, 1, '2018-12-31', NULL, NULL), (2, 2, 0, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM (SELECT PRODUCT_ID FROM (SELECT PRODUCT_ID, SUM(SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') AS SPRING_CNT, COUNT(*) AS TOTAL_CNT FROM SALES GROUP BY PRODUCT_ID) AS T WHERE (SPRING_CNT >= 1) AND (TOTAL_CNT - SPRING_CNT = 0)) AS L LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = L.PRODUCT_ID;

/*
Prediction Result:
(None, None)
*/