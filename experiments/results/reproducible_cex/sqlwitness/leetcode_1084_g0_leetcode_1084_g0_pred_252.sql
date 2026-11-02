-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, '2019-03-31', NULL), (2, '2019-01-01', NULL), (3, 'default2', NULL), (4, ' 2019-01-01', NULL), (5, ' 2019-01-01', NULL), (6, 'default1', 1), (7, NULL, 1), (8, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, 1, '2018-12-31', NULL, NULL), (3, 1, 0, '2018-12-31', 1, NULL), (1, 1, NULL, '2019-01-01', NULL, 1), (7, 0, 0, NULL, NULL, NULL), (6, NULL, NULL, '2019-03-31', 1, NULL), (6, 0, NULL, '2018-12-31', 1, NULL), (1, 1, NULL, '2019-03-31', 1, NULL), (6, 1, NULL, NULL, NULL, NULL), (8, 0, 1, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(8, '2019-03-31')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING ' 2019-01-01' <= MIN(S.SALE_DATE) AND MAX(S.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(1, None)
(3, 'default2')
(6, 'default1')
(8, '2019-03-31')
*/