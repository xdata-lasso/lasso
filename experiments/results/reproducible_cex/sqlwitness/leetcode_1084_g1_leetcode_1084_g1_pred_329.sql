-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (1, '2019-01-01', NULL), (2, 'default1', 1), (3, '2019-03-31', NULL), (4, '2019-01-01', 1), (5, '2019-01-01', 1), (6, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, NULL, '2019-03-30', 1, 1), (6, 1, 1, '2023-01-02', 1, NULL), (6, 1, 0, '2018-12-31', NULL, 1), (0, 1, 0, '2019-03-30', NULL, 1), (5, 0, NULL, '2019-03-31', 1, NULL), (3, NULL, 1, '2019-03-30', 1, 1), (NULL, 0, 0, '2019-01-01', NULL, NULL), (4, 1, NULL, NULL, NULL, NULL), (NULL, 1, 0, '2019-03-31', NULL, 1), (NULL, NULL, 1, '2019-04-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH FIRST_QUARTER_ONLY AS (SELECT SALES.PRODUCT_ID AS PRODUCT_ID FROM SALES GROUP BY SALES.PRODUCT_ID HAVING MIN(SALES.SALE_DATE) >= '2019-01-01' AND MAX(SALES.SALE_DATE) <= '2019-03-31') SELECT PRODUCT.PRODUCT_ID AS PRODUCT_ID, PRODUCT.PRODUCT_NAME AS PRODUCT_NAME FROM PRODUCT WHERE PRODUCT.PRODUCT_ID IN (SELECT * FROM FIRST_QUARTER_ONLY);

/*
Prediction Result:
(0, '2019-03-31')
(3, '2019-03-31')
(5, '2019-01-01')
*/