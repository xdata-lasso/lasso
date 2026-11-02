-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-03-31', NULL), (3, '2019-01-01', NULL), (1, '2019-03-31', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 2, NULL, NULL, NULL), (1, 0, 2, '2023-01-01', NULL, NULL), (1, 0, 1, '2023-01-02', NULL, 3), (2, 2, 2, '2019-03-30', 2, 3), (2, 3, 0, '2023-01-01', NULL, NULL), (2, 1, 0, '2018-12-31', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, '2019-01-01')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P CROSS JOIN SALES AS S WHERE P.PRODUCT_ID = S.PRODUCT_ID GROUP BY 1, 2 HAVING MIN(S.SALE_DATE) >= '2019-01-01' AND MAX(S.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
*/