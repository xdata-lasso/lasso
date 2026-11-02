-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, 'default1', 1), (2, 'default1', 1), (3, '2019-03-31', 1), (4, '2019-01-01', NULL), (5, 'default1', NULL), (6, 'default2', 1), (7, '2019-03-31', NULL), (8, NULL, NULL), (9, '2019-01-01', NULL), (10, '2019-03-31', NULL), (11, 'default2', NULL), (12, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 1, 1, NULL, NULL, 1), (11, NULL, 1, NULL, NULL, NULL), (11, NULL, 0, '2019-04-01', NULL, NULL), (3, NULL, 0, '2019-04-01', 1, NULL), (12, NULL, NULL, NULL, NULL, 1), (3, NULL, NULL, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(12, 'default2')
*/

-- Prediction Query
SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.PRODUCT_ID, B.PRODUCT_NAME HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
*/