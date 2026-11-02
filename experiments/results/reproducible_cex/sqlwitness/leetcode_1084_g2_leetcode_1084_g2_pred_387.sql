-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (1, 'default2', 1), (-1, 'default1', 1), (2, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, -1, 0, '2019-01-02', NULL, NULL), (0, 1, 1, '2019-01-02', 1, NULL), (NULL, 1, 1, '2019-03-31', NULL, NULL), (2, -1, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, None)
(1, 'default2')
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT INNER JOIN (SELECT DISTINCT (S1.PRODUCT_ID) FROM SALES AS S1 LEFT JOIN (SELECT DISTINCT (S2.PRODUCT_ID) FROM SALES AS S2 WHERE NOT S2.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AS S3 ON S1.PRODUCT_ID = S3.PRODUCT_ID WHERE S3.PRODUCT_ID IS NULL) AS TEMP ON PRODUCT.PRODUCT_ID = TEMP.PRODUCT_ID;

/*
Prediction Result:
(0, None)
(1, 'default2')
(2, '2019-01-01')
*/