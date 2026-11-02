-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 2, 1, '2019-04-01', NULL, 2), (0, 2, NULL, '2019-01-01', 1, 2), (0, -1, 2, NULL, 1, NULL), (NULL, 2, -1, '2019-01-02', NULL, NULL), (NULL, 0, -1, '2019-03-30', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.PRODUCT_ID, T2.PRODUCT_NAME FROM (SELECT *, CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END AS SPRING_SALE FROM SALES) AS T1 LEFT JOIN PRODUCT AS T2 ON T2.PRODUCT_ID = T1.PRODUCT_ID GROUP BY T1.PRODUCT_ID HAVING CAST(SUM(SPRING_SALE) AS REAL) / COUNT(SPRING_SALE) = 1;

/*
Prediction Result:
(None, None)
*/