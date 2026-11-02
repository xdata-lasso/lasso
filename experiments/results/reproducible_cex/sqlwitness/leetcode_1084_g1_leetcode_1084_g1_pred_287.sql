-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, 1), (-1, '2019-03-31', NULL), (1, 'default1', NULL), (2, '2019-01-01', 1), (3, NULL, NULL), (4, 'default1', NULL), (5, NULL, NULL), (6, 'default2', 1), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 0, NULL, NULL, NULL, NULL), (4, 1, NULL, '2018-12-31', NULL, 1), (1, 0, 1, '2023-01-01', NULL, 1), (2, 1, NULL, '2018-12-31', 1, NULL), (5, NULL, 1, '2019-03-31', 1, NULL), (0, NULL, 1, '2019-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(6, 'default2')
(5, None)
(0, None)
*/

-- Prediction Query
WITH TMP AS (SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM TMP WHERE NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID AS PRODUCT_ID FROM SALES WHERE CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-01-01')) AS INTEGER) < 0 OR CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-03-31')) AS INTEGER) > 0);

/*
Prediction Result:
(5, None)
(0, None)
*/