-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 3), (0, '2019-03-31', NULL), (3, NULL, NULL), (2, '2019-03-31', 1), (4, '2019-01-01', NULL), (5, '2019-03-31', NULL), (6, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 3, NULL, NULL, 1), (6, 2, 3, '2019-04-01', NULL, 1), (4, 3, 3, NULL, 2, NULL), (NULL, 1, NULL, '2018-12-31', 1, 3), (1, 0, 3, '2019-04-01', NULL, NULL), (4, NULL, 1, NULL, 1, NULL), (0, 0, NULL, '2019-01-02', 2, 1), (NULL, 1, NULL, '2019-03-30', 2, 1), (6, 0, 3, '2019-03-31', 2, 3), (0, 0, 3, '2018-12-31', NULL, 3), (2, 0, 2, NULL, NULL, 3), (NULL, 3, 3, '2023-01-02', 3, 1), (2, 0, 0, '2023-01-01', 3, 3), (4, 2, 3, '2019-03-30', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1, 2 HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(4, '2019-01-01')
*/