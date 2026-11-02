-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, '2019-03-31', NULL), (2, 'default2', 1), (3, 'default1', 1), (4, NULL, 1), (5, NULL, NULL), (6, '2019-03-31', 1), (7, 'default1', NULL), (8, '2019-03-31', 1), (9, 'default2', NULL), (10, 'default2', NULL), (11, 'default2', NULL), (12, '2019-03-31', NULL), (13, '2019-01-01', NULL), (14, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, NULL, 0, '2023-01-01', NULL, 1), (3, 0, 1, '2023-01-02', 1, NULL), (3, NULL, 0, '2019-03-30', NULL, NULL), (0, NULL, NULL, '2019-03-31', NULL, 1), (4, 0, 1, NULL, 1, NULL), (2, NULL, 0, '2019-04-01', 1, NULL), (6, NULL, 1, '2023-01-01', NULL, 1), (6, NULL, NULL, '2019-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') AND PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES);

/*
Prediction Result:
(0, 'default1')
(4, None)
*/