-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, '2019-01-01', NULL), (1, '2019-01-01', 1), (0, NULL, 1), (2, 'default1', NULL), (3, '2019-01-01', 1), (4, 'default1', 1), (5, NULL, 1), (6, NULL, 1), (7, '2019-03-31', 1), (8, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, -1, NULL, '2019-03-31', NULL, 1), (-1, 1, 0, '2019-03-31', NULL, 1), (5, -1, 0, '2019-03-30', NULL, NULL), (-1, 1, NULL, '2019-04-01', 1, 1), (NULL, NULL, NULL, '2019-01-01', NULL, NULL), (2, NULL, -1, NULL, 1, NULL), (5, -1, 0, '2019-03-31', 1, NULL), (1, 0, 1, '2023-01-01', NULL, NULL), (0, 1, 0, NULL, NULL, NULL), (7, -1, 1, '2019-01-02', NULL, 1), (3, 1, 0, '2018-12-31', 1, 1), (-1, 1, 0, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(4, 'default1')
(5, None)
(7, '2019-03-31')
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES CROSS JOIN PRODUCT WHERE PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID AND NOT SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') GROUP BY SALES.PRODUCT_ID;

/*
Prediction Result:
(0, None)
(2, 'default1')
(4, 'default1')
(5, None)
(7, '2019-03-31')
*/