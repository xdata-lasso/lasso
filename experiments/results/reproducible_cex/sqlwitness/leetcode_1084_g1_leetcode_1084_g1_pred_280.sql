-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, 'default2', 1), (2, '2019-01-01', NULL), (3, '2019-01-01', NULL), (4, 'default1', 1), (5, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, NULL, '2019-04-01', 1, NULL), (2, NULL, 0, NULL, 1, NULL), (NULL, 0, 1, NULL, 1, 1), (3, 1, 1, '2019-04-01', NULL, NULL), (NULL, 1, NULL, NULL, 1, NULL), (3, 0, 0, '2019-01-02', NULL, 1), (4, NULL, 1, '2019-01-02', NULL, NULL), (4, 1, 1, NULL, 1, NULL), (5, 1, 0, '2019-01-02', 1, 1), (NULL, 0, 1, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH T(PRODUCT_ID) AS (SELECT DISTINCT P.PRODUCT_ID FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID LEFT JOIN T ON T.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND T.PRODUCT_ID IS NULL;

/*
Prediction Result:
(4, 'default1')
(5, '2019-01-01')
*/