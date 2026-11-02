-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, NULL, NULL), (2, 'default1', NULL), (3, '2019-03-31', 1), (4, 'default1', NULL), (5, '2019-01-01', 1), (6, 'default1', 1), (7, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, NULL, '2018-12-31', 1, 1), (6, 0, 0, '2018-12-31', 1, 1), (3, 0, NULL, '2019-03-30', 1, NULL), (1, 1, 1, '2019-01-01', NULL, NULL), (5, 1, NULL, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, '2019-03-31')
(1, None)
(5, '2019-01-01')
*/

-- Prediction Query
SELECT A1.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM (SELECT DISTINCT SALES.PRODUCT_ID FROM SALES WHERE SALES.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT SALES.PRODUCT_ID FROM SALES WHERE NOT SALES.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31')) AS A1 JOIN PRODUCT ON A1.PRODUCT_ID = PRODUCT.PRODUCT_ID ORDER BY A1.PRODUCT_ID, PRODUCT.product_id NULLS LAST;

/*
Prediction Result:
(1, None)
(3, '2019-03-31')
(5, '2019-01-01')
*/