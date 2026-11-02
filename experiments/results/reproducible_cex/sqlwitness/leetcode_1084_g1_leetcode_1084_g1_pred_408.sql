-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 1), (1, NULL, NULL), (2, '2019-01-01', 1), (3, '2019-03-31', NULL), (4, 'default2', 1), (5, 'default1', NULL), (6, 'default2', NULL), (7, '2019-01-01', 1), (8, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, NULL, '2019-01-01', 1, 1), (NULL, 1, NULL, '2019-04-01', NULL, NULL), (8, NULL, 0, NULL, 1, 1), (4, 0, NULL, '2019-03-30', NULL, NULL), (6, NULL, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT CROSS JOIN SALES WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID GROUP BY SALES.PRODUCT_ID HAVING MAX(SALES.SALE_DATE) <= '2019-03-31' AND MIN(SALES.SALE_DATE) >= '2019-01-01';

/*
Prediction Result:
(4, 'default2')
*/