-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', 2), (-1, '2019-03-31', 2), (1, NULL, NULL), (2, '2019-01-01', 1), (3, 'default1', 2), (4, '2019-03-31', NULL), (5, '2019-03-31', 1), (6, '2019-03-31', 2), (7, NULL, 1), (8, '2019-01-01', NULL), (9, NULL, NULL), (10, '2019-03-31', 1), (11, '2019-01-01', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 2, '2019-04-01', NULL, 2), (6, -1, 1, '2019-03-31', NULL, NULL), (4, 2, 2, '2019-01-02', 1, 1), (1, 1, 2, '2019-03-30', NULL, 1), (-1, -1, 2, '2018-12-31', 1, NULL), (2, 2, 2, '2019-04-01', 2, NULL), (NULL, 2, 2, NULL, NULL, NULL), (4, -1, NULL, NULL, 2, 1), (8, 1, 0, '2019-03-30', 1, NULL), (8, 2, 1, '2019-04-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, None)
(4, '2019-03-31')
(6, '2019-03-31')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING SUM(IIF(SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 0, 1)) = 0;

/*
Prediction Result:
(1, None)
(6, '2019-03-31')
*/