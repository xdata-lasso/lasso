-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, '2019-01-01', 1), (2, 'default1', NULL), (3, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 0, '2019-01-02', 1, NULL), (3, 1, NULL, NULL, NULL, NULL), (0, NULL, 0, '2019-03-30', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, 'default2')
(0, '2019-01-01')
*/

-- Prediction Query
WITH TEMP_TABLE AS (SELECT PRODUCT_ID FROM SALES AS S WHERE (S.SALE_DATE >= '2019-01-01' AND S.SALE_DATE <= '2019-03-31') AND NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01')) SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM TEMP_TABLE AS T JOIN PRODUCT AS P ON T.PRODUCT_ID = P.PRODUCT_ID ORDER BY T.PRODUCT_ID, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(0, '2019-01-01')
(3, 'default2')
*/