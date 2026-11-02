-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 2), (-1, 'default1', 1), (2, NULL, 2), (1, 'default1', 2), (3, '2019-01-01', 1), (4, 'default1', NULL), (5, '2019-03-31', NULL), (6, '2019-03-31', NULL), (7, 'default1', 2), (8, '2019-01-01', 2), (9, 'default2', NULL), (10, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 0, NULL, 2, NULL), (5, 1, 2, '2018-12-31', NULL, 1), (4, -1, 1, '2019-01-01', 1, NULL), (10, 1, 1, '2019-03-31', NULL, 1), (7, -1, -1, '2023-01-01', NULL, NULL), (NULL, -1, NULL, '2018-12-31', 2, NULL), (6, -1, NULL, NULL, 2, NULL), (4, 1, 2, NULL, NULL, 1), (9, 0, -1, NULL, 1, 1), (NULL, -1, -1, '2019-03-31', 1, 1), (2, -1, 2, '2019-01-01', NULL, 2), (9, -1, 0, '2019-04-01', 2, NULL), (6, NULL, 2, '2019-03-30', 2, 1), (1, 2, 1, '2019-03-31', 2, NULL), (1, 2, 1, '2019-04-01', 2, 1), (-1, 1, 2, '2019-01-01', 1, 1), (4, NULL, NULL, '2018-12-31', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1 HAVING SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) = COUNT(P.PRODUCT_ID);

/*
Prediction Result:
(-1, 'default1')
(10, None)
*/