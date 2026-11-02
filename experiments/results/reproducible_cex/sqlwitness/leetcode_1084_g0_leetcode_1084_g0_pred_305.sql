-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 2), (-1, '2019-01-01', NULL), (1, NULL, 1), (2, '2019-01-01', 2), (3, '2019-01-01', NULL), (4, 'default1', 2), (5, '2019-03-31', 1), (6, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, -1, 1, '2019-03-31', 1, 1), (5, NULL, 1, '2019-03-30', 2, 2), (2, 1, 2, '2019-01-02', 2, 2), (6, NULL, NULL, '2018-12-31', 1, 1), (5, -1, 1, NULL, 2, 2), (-1, 2, NULL, '2019-01-02', 1, 2), (1, NULL, 2, '2019-01-02', NULL, NULL), (0, 2, NULL, '2023-01-02', 1, NULL), (-1, 1, 2, '2019-04-01', 1, 2), (NULL, NULL, 2, '2019-01-02', 2, 2), (NULL, 0, 2, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, None)
(2, '2019-01-01')
(5, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
(1, None)
(2, '2019-01-01')
*/