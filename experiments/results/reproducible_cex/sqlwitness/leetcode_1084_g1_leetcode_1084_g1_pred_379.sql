-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, '2019-01-01', 2), (2, 'default1', 2), (3, 'default1', 2), (4, '2019-01-01', 1), (5, '2019-01-01', 2), (6, 'default2', 2), (7, '2019-03-31', 2), (8, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 1, '2019-03-30', 2, 1), (8, 0, 1, '2019-04-01', NULL, NULL), (4, 2, 1, '2019-01-02', NULL, 1), (1, 1, NULL, '2019-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, '2019-01-01')
(1, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID AND P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') ORDER BY 1, P.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(1, '2019-01-01')
(4, '2019-01-01')
*/