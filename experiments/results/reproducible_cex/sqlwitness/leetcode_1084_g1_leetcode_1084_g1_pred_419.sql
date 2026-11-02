-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'default2', NULL), (2, NULL, 1), (3, 'default2', NULL), (4, '2019-03-31', NULL), (5, '2019-03-31', NULL), (6, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 0, 0, NULL, 1, NULL), (6, 1, NULL, '2019-01-02', 1, 1), (3, NULL, 0, '2018-12-31', 1, 1), (3, 0, NULL, '2023-01-02', NULL, NULL), (6, 1, NULL, '2019-04-01', 1, 1), (0, 0, 1, '2023-01-02', NULL, NULL), (3, 0, 0, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(5, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON S.PRODUCT_ID = P.PRODUCT_ID AND SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' WHERE NOT P.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S WHERE (SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31'));

/*
Prediction Result:
*/