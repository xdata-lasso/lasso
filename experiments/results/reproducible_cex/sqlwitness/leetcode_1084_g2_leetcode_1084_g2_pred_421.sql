-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (-1, 'default2', 1), (0, 'default1', 1), (2, 'default2', NULL), (3, 'default2', NULL), (4, '2019-03-31', 1), (5, 'default1', NULL), (6, NULL, 1), (7, 'default2', NULL), (8, 'default1', NULL), (9, NULL, 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (8, -1, 0, '2019-03-31', NULL, NULL), (4, 1, NULL, '2019-03-31', 1, 1), (1, NULL, 1, '2023-01-02', NULL, 1), (6, 0, 0, NULL, 1, 1), (4, -1, 1, '2019-01-01', 1, 1), (3, 0, -1, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(4, '2019-03-31')
(8, 'default1')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE NOT PRODUCT.PRODUCT_ID IN (SELECT PRODUCT.PRODUCT_ID FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALES.SALE_DATE > '2019-03-31' OR SALES.SALE_DATE < '2019-01-01');

/*
Prediction Result:
(8, 'default1')
(4, '2019-03-31')
(6, None)
*/