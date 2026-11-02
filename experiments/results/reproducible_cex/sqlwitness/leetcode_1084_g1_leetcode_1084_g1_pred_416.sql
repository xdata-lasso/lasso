-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, NULL, NULL), (1, '2019-01-01', NULL), (-1, '2019-01-01', NULL), (2, '2019-03-31', 1), (3, 'default2', NULL), (4, '2019-01-01', NULL), (5, NULL, NULL), (6, '2019-03-31', 1), (7, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, -1, NULL, NULL, NULL, 1), (1, 1, 0, '2019-03-31', 1, NULL), (3, 0, NULL, '2019-03-31', 1, 1), (1, 0, 0, '2019-04-01', 1, NULL), (3, 1, -1, '2019-04-01', 1, 1), (4, 1, 1, NULL, 1, 1), (3, 1, 1, '2019-01-02', NULL, NULL), (7, 0, 0, '2019-01-01', 1, 1), (6, -1, -1, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, None)
(4, '2019-01-01')
(7, 'default1')
(6, '2019-03-31')
*/

-- Prediction Query
WITH T1 AS (SELECT PRODUCT_ID AS PID FROM SALES GROUP BY PID HAVING SUM(SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') = 0) SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN T1 ON PRODUCT.PRODUCT_ID = T1.PID;

/*
Prediction Result:
(6, '2019-03-31')
(7, 'default1')
*/