-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, '2019-01-01', NULL), (2, 'default1', 1), (3, 'default1', NULL), (4, '2019-03-31', NULL), (5, 'default2', NULL), (6, '2019-03-31', NULL), (7, '2019-03-31', 1), (8, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, NULL, 1, NULL, NULL, NULL), (8, 0, 1, '2023-01-02', 1, NULL), (1, 1, 0, '2023-01-01', 1, NULL), (1, 0, NULL, '2019-01-01', NULL, NULL), (6, NULL, NULL, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(2, 'default1')
*/

-- Prediction Query
SELECT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A INNER JOIN (SELECT PRODUCT_ID, MAX(SALE_DATE) AS A1, MIN(SALE_DATE) AS A2 FROM SALES GROUP BY PRODUCT_ID) AS TEMP ON TEMP.PRODUCT_ID = A.PRODUCT_ID WHERE TEMP.A1 <= '2019-03-31' AND TEMP.A2 >= '2019-01-01';

/*
Prediction Result:
*/