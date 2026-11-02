-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', 2), (1, 'default1', 2), (0, '2019-01-01', 1), (2, 'default1', NULL), (3, 'default2', 2), (4, '2019-03-31', 2), (5, 'default1', 2), (6, NULL, 2), (7, 'default1', 2), (8, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 2, NULL, '2019-04-01', NULL, 1), (NULL, 0, 1, '2023-01-01', 2, NULL), (NULL, 0, NULL, '2019-04-01', 1, 2), (7, 2, -1, '2019-04-01', 1, 1), (2, 0, 1, '2019-01-02', NULL, 2), (2, 0, -1, '2018-12-31', 1, 2), (4, 0, -1, '2023-01-02', NULL, NULL), (4, 2, 2, '2019-03-31', NULL, NULL), (8, 1, 1, '2019-01-01', 2, 2), (8, NULL, -1, '2023-01-02', NULL, 2), (NULL, 2, NULL, '2018-12-31', 1, 1), (3, -1, -1, '2019-01-02', 2, 2), (4, 2, 2, '2019-04-01', NULL, 1), (8, 2, 0, '2019-04-01', 1, 2), (8, NULL, 0, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_ID, (CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 1 ELSE 0 END) AS SPRING_SALE FROM SALES), B AS (SELECT PRODUCT_ID, SUM(SPRING_SALE) AS SPRING_SALE, COUNT(*) AS TOTAL FROM A GROUP BY PRODUCT_ID HAVING SPRING_SALE <> 0 AND TOTAL = SPRING_SALE) SELECT B.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM B JOIN PRODUCT ON B.PRODUCT_ID = PRODUCT.PRODUCT_ID;

/*
Prediction Result:
(3, 'default2')
*/