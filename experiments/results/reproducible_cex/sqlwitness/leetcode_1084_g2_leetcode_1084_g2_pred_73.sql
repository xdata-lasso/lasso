-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, NULL, NULL), (0, 'default1', NULL), (1, '2019-01-01', 1), (2, 'default1', NULL), (3, 'default2', NULL), (4, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 0, '2019-01-01', NULL, 1), (NULL, -1, 1, '2019-03-30', NULL, 1), (3, -1, NULL, '2018-12-31', NULL, NULL), (NULL, NULL, 1, '2019-03-31', NULL, NULL), (3, NULL, NULL, '2018-12-31', NULL, 1), (-1, 1, 0, '2019-04-01', NULL, 1), (-1, 1, NULL, '2019-01-01', 1, 1), (1, 1, -1, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING MAX(SALE_DATE) <= '2019-03-31' AND MIN(SALE_DATE) >= '2019-01-01';

/*
Prediction Result:
(None, None)
(4, 'default1')
*/