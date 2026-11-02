-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 1), (1, 'default1', 1), (2, 'default2', NULL), (3, 'default2', NULL), (4, '2019-01-01', 1), (5, 'default1', 1), (6, '2019-03-31', 1), (7, '2019-01-01', 1), (8, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, NULL, '2023-01-01', NULL, NULL), (3, 1, NULL, '2023-01-01', 1, NULL), (3, 0, NULL, '2023-01-02', 1, NULL), (3, NULL, 0, '2019-03-30', NULL, NULL), (3, NULL, NULL, '2023-01-02', NULL, 1), (8, 0, 0, '2019-04-01', NULL, NULL), (4, NULL, 0, '2023-01-01', 1, 1), (5, 0, 1, '2019-01-02', 1, NULL), (NULL, NULL, NULL, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(5, 'default1')
*/

-- Prediction Query
SELECT DISTINCT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT.PRODUCT_ID IN (SELECT SALES.PRODUCT_ID FROM SALES WHERE SALES.SALE_DATE > '2019-03-31' OR SALES.SALE_DATE < '2019-01-01') AND PRODUCT.PRODUCT_ID IN (SELECT SALES.PRODUCT_ID FROM SALES);

/*
Prediction Result:
*/