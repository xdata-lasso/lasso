-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', NULL), (0, '2019-01-01', 1), (-1, 'default2', 2), (1, '2019-03-31', NULL), (3, 'default2', 2), (4, 'default2', 2), (5, '2019-03-31', 2), (6, 'default2', 2), (7, '2019-01-01', NULL), (8, 'default2', 1), (9, '2019-03-31', 1), (10, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, NULL, '2019-01-01', NULL, 1), (9, 1, 0, '2018-12-31', 1, 1), (2, 2, NULL, '2019-01-02', 1, 2), (6, 2, 1, '2023-01-02', NULL, 2), (0, 2, 2, '2023-01-01', 2, 1), (2, -1, 2, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(2, 'default2')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT USING (PRODUCT_ID) GROUP BY 1 HAVING MAX(SALE_DATE) <= '2019-03-31' AND MIN(SALE_DATE) >= '2019-01-01';

/*
Prediction Result:
(None, None)
(2, 'default2')
*/