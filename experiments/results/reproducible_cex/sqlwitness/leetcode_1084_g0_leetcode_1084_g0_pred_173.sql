-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', NULL), (1, NULL, NULL), (2, 'default2', 1), (3, 'default2', NULL), (4, '2019-01-01', 1), (5, '2019-03-31', NULL), (6, 'default2', 1), (7, 'default2', 1), (8, '2019-03-31', 1), (9, '2019-03-31', NULL), (10, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, NULL, '2023-01-02', 1, NULL), (3, 1, 1, '2019-01-01', 1, NULL), (10, NULL, NULL, '2023-01-02', 1, 1), (5, NULL, NULL, '2018-12-31', 1, NULL), (8, NULL, 1, '2018-12-31', 1, 1), (NULL, 0, 1, '2019-03-31', NULL, NULL), (0, 1, 0, '2018-12-31', 1, 1), (NULL, NULL, 0, '2019-04-01', 1, NULL), (8, NULL, 0, '2019-03-30', 1, NULL), (8, NULL, 0, '2018-12-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, 'default2')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') AND SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' ORDER BY S.PRODUCT_ID, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
*/