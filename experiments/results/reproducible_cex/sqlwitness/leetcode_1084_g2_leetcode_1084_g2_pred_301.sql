-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, NULL, NULL), (-1, '2019-03-31', NULL), (2, '2019-03-31', NULL), (3, 'default2', 1), (4, 'default1', NULL), (5, 'default2', 1), (6, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, 1, '2019-01-01', 1, 1), (5, 1, NULL, '2019-01-01', 1, 1), (0, -1, 0, NULL, NULL, NULL), (2, 1, 0, '2019-04-01', NULL, NULL), (0, 0, -1, '2019-01-02', NULL, 1), (4, 0, 1, '2019-04-01', NULL, NULL), (-1, NULL, -1, '2019-03-30', NULL, NULL), (3, 0, -1, '2019-03-30', 1, NULL), (3, NULL, 1, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(-1, '2019-03-31')
(0, None)
(3, 'default2')
(5, 'default2')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P WHERE P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES AS S GROUP BY S.PRODUCT_ID HAVING MAX(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01' AND MIN(S.SALE_DATE) BETWEEN '2019-01-01' AND '2019-04-01');

/*
Prediction Result:
(-1, '2019-03-31')
(0, None)
(2, '2019-03-31')
(3, 'default2')
(4, 'default1')
(5, 'default2')
*/