-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (0, 'default2', NULL), (-1, 'default2', NULL), (2, NULL, NULL), (3, 'default2', 1), (4, NULL, 1), (5, 'default2', 1), (6, 'default1', NULL), (7, '2019-03-31', 1), (8, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, NULL, NULL, '2018-12-31', 1, NULL), (5, 0, 1, '2019-03-30', 1, 1), (NULL, -1, NULL, '2023-01-02', NULL, NULL), (2, 1, -1, '2019-01-01', NULL, NULL), (5, 0, 1, '2023-01-02', NULL, NULL), (7, 0, 1, '2018-12-31', NULL, NULL), (-1, NULL, NULL, '2019-04-01', 1, NULL), (NULL, -1, NULL, '2023-01-02', NULL, NULL), (8, 1, -1, '2023-01-02', NULL, 1), (4, 0, 0, '2019-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(2, None)
(4, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID AND SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES AS S WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME ORDER BY P.PRODUCT_ID, P.PRODUCT_NAME;

/*
Prediction Result:
*/