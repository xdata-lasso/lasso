-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (2, 'default2', NULL), (0, NULL, NULL), (3, NULL, 1), (4, 'default2', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 0, '2018-12-31', NULL, NULL), (4, 1, 1, '2019-04-01', 1, 1), (1, 1, 1, '2019-03-30', 1, 1), (3, 1, 1, '2018-12-31', 2, 1), (3, 1, 2, '2023-01-01', 1, 1), (NULL, NULL, 2, '2018-12-31', 2, NULL), (4, 1, NULL, '2019-03-31', 2, 1), (4, 2, 0, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT Q1_ONLY.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM (SELECT PRODUCT_ID FROM SALES GROUP BY 1 HAVING MAX(SALE_DATE) <= '2019-03-31' AND MIN(SALE_DATE) >= '2019-01-01') AS Q1_ONLY JOIN PRODUCT ON PRODUCT.PRODUCT_ID = Q1_ONLY.PRODUCT_ID;

/*
Prediction Result:
(1, 'default1')
*/