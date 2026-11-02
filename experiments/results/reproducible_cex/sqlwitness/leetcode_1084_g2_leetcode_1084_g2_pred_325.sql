-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-1-1', NULL), (2, 'default1', 1), (1, '2019-03-31', NULL), (-1, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 1, NULL, 2, 2), (2, 2, -1, '2019-03-30', 1, NULL), (-1, NULL, 0, NULL, 2, NULL), (-1, NULL, NULL, '2018-12-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(2, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P WHERE EXISTS(SELECT 1 FROM SALES AS A WHERE A.SALE_DATE BETWEEN '2019-1-1' AND '2019-03-31' AND A.PRODUCT_ID = P.PRODUCT_ID) AND NOT EXISTS(SELECT 1 FROM SALES AS B WHERE (B.SALE_DATE > '2019-03-31' OR B.SALE_DATE < '2019-01-01') AND B.PRODUCT_ID = P.PRODUCT_ID);

/*
Prediction Result:
*/