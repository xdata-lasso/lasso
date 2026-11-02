-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, '2019-01-01', NULL), (2, NULL, 1), (3, 'default2', 1), (4, '2019-03-31', NULL), (5, '2019-01-01', NULL), (6, 'default1', 1), (7, NULL, 1), (8, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, NULL, '2019-03-30', NULL, NULL), (1, 1, 1, NULL, NULL, NULL), (6, NULL, NULL, '2023-01-02', 1, NULL), (NULL, NULL, NULL, '2019-04-01', 1, 1), (7, 0, 0, '2019-01-02', NULL, NULL), (3, NULL, 0, '2023-01-01', 1, NULL), (5, NULL, NULL, '2023-01-02', 1, 1), (7, 1, 0, NULL, 1, 1), (7, 1, 0, NULL, NULL, NULL), (8, NULL, 1, '2019-01-01', 1, NULL), (3, NULL, NULL, '2019-04-01', 1, NULL), (3, NULL, 0, '2019-03-30', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY SALES.PRODUCT_ID HAVING MIN(SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31' AND MAX(SALE_DATE) BETWEEN '2019-01-01' AND '2019-03-31';

/*
Prediction Result:
(7, None)
(8, '2019-01-01')
*/