-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, 'default1', NULL), (2, '2019-03-31', NULL), (3, '2019-03-31', 1), (4, '2019-03-31', NULL), (5, 'default2', 1), (6, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE NOT P.PRODUCT_ID IN (SELECT DISTINCT S.PRODUCT_ID FROM SALES AS S WHERE S.SALE_DATE < '2019-01-01' OR S.SALE_DATE > '2019-03-31');

/*
Prediction Result:
(0, '2019-01-01')
(1, 'default1')
(2, '2019-03-31')
(3, '2019-03-31')
(4, '2019-03-31')
(5, 'default2')
(6, 'default2')
*/