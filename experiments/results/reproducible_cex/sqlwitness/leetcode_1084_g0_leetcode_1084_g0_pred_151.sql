-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', 1), (0, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, NULL, NULL, NULL, 1), (-1, -1, 1, '2019-01-01', 1, NULL), (NULL, -1, NULL, '2019-03-30', NULL, 1), (-1, 0, 1, '2019-01-02', NULL, NULL), (NULL, NULL, 0, '2019-03-30', 1, 1), (-1, 0, -1, '2019-03-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(-1, 'default1')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE CAST((JULIANDAY(S.SALE_DATE) - JULIANDAY('2019-01-01')) AS INTEGER) >= 0 AND CAST((JULIANDAY('2019-03-31') - JULIANDAY(S.SALE_DATE)) AS INTEGER) >= 0 AND NOT P.PRODUCT_ID IN (SELECT DISTINCT P.PRODUCT_ID FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE CAST((JULIANDAY('2019-01-01') - JULIANDAY(S.SALE_DATE)) AS INTEGER) > 0 OR CAST((JULIANDAY(S.SALE_DATE) - JULIANDAY('2019-03-31')) AS INTEGER) > 0);

/*
Prediction Result:
(-1, 'default1')
(None, None)
*/