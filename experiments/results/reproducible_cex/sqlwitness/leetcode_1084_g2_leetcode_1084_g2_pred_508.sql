-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (-1, 'default1', 1), (1, NULL, 1), (0, NULL, 1), (2, 'default2', NULL), (3, 'default2', NULL), (4, 'default1', 1), (5, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, NULL, -1, '2019-03-31', 1, 1), (NULL, -1, 0, NULL, NULL, NULL), (0, 0, NULL, '2019-03-31', NULL, 1), (2, 1, NULL, '2019-04-01', 1, NULL), (2, NULL, 1, '2019-01-02', 1, NULL), (NULL, -1, 0, '2023-01-01', 1, 1), (3, 1, -1, '2023-01-02', NULL, 1), (3, 1, 0, '2023-01-02', NULL, NULL), (0, 1, -1, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(0, None)
(1, None)
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, A.PRODUCT_NAME FROM (SELECT SALES.PRODUCT_ID, SALES.SALE_DATE, PRODUCT.PRODUCT_NAME FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID) AS A WHERE NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/