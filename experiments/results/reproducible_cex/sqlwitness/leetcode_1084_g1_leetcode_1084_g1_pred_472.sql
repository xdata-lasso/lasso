-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (-1, 'default2', 1), (1, 'default2', NULL), (2, NULL, NULL), (3, '2019-03-31', NULL), (4, NULL, NULL), (5, 'default1', NULL), (6, NULL, NULL), (7, 'default1', 1), (8, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, -1, '2019-01-01', NULL, NULL), (NULL, 0, 0, '2019-03-30', NULL, 1), (8, 1, 0, '2019-01-01', NULL, 1), (2, NULL, -1, '2019-04-01', NULL, NULL), (0, 0, NULL, '2019-01-02', 1, 1), (3, NULL, 0, '2018-12-31', NULL, 1), (4, -1, 1, '2023-01-01', 1, 1), (5, NULL, NULL, '2019-03-30', NULL, 1), (NULL, NULL, NULL, '2023-01-01', 1, 1), (-1, 1, 0, '2019-01-01', 1, 1), (0, NULL, NULL, '2019-03-30', NULL, 1), (6, 0, 0, '2018-12-31', 1, NULL), (1, NULL, -1, '2019-03-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM (SELECT PRODUCT_NAME, SALES.PRODUCT_ID AS PRODUCT_ID, SALE_DATE FROM SALES LEFT JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) AS T GROUP BY PRODUCT_ID HAVING SUM(SALE_DATE <= '2019-03-31' AND SALE_DATE >= '2019-01-01') > 0 AND SUM(SALE_DATE > '2019-03-31') = 0 AND SUM(SALE_DATE < '2019-01-01') = 0;

/*
Prediction Result:
(-1, 'default2')
(0, '2019-03-31')
(1, 'default2')
(5, 'default1')
(8, None)
*/