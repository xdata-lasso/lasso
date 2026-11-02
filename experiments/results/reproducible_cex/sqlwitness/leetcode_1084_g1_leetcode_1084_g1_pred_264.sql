-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, 'default2', NULL), (2, 'default1', NULL), (3, '2019-03-31', NULL), (4, 'default1', NULL), (5, '2019-03-31', 1), (6, 'default2', NULL), (7, 'default2', 1), (8, NULL, 1), (9, '2019-03-31', 1), (10, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, NULL, '2019-01-01', NULL, NULL), (3, 0, NULL, NULL, 1, NULL), (6, NULL, NULL, '2023-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, 'default1')
(3, '2019-03-31')
*/

-- Prediction Query
WITH C1 AS (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31')) SELECT C1.PRODUCT_ID, P.PRODUCT_NAME FROM C1 LEFT JOIN PRODUCT AS P USING (PRODUCT_ID);

/*
Prediction Result:
(4, 'default1')
*/