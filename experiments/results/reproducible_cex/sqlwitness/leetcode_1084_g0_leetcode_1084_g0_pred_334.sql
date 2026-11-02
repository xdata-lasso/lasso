-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, '2019-01-01', 1), (2, 'default1', NULL), (3, NULL, 1), (4, 'default1', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 1, '2019-01-01', NULL, NULL), (0, 0, 1, '2019-01-01', NULL, NULL), (1, 1, 0, '2019-03-30', 1, 1), (3, 0, 1, '2019-03-30', NULL, NULL), (4, NULL, 1, '2023-01-01', NULL, 1), (1, 1, NULL, '2019-01-01', NULL, NULL), (2, NULL, NULL, '2019-03-30', 1, NULL), (0, NULL, NULL, NULL, 1, 1), (0, NULL, 1, '2023-01-01', NULL, 1), (NULL, NULL, 1, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'default1')
(2, 'default1')
(3, None)
*/

-- Prediction Query
SELECT DISTINCT TEMP_1.PRODUCT_ID, P.PRODUCT_NAME FROM (SELECT PRODUCT_ID, MAX(SALE_DATE) AS LD, MIN(SALE_DATE) AS FD FROM SALES GROUP BY PRODUCT_ID HAVING LD BETWEEN '2019-01-01' AND '2019-03-31' AND FD BETWEEN '2019-01-01' AND '2019-03-31') AS TEMP_1 LEFT JOIN PRODUCT AS P ON TEMP_1.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
(None, None)
(1, 'default1')
(2, 'default1')
(3, None)
*/