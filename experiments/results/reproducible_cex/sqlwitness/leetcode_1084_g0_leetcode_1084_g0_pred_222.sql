-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (2, '2019-01-01', 1), (1, NULL, 1), (3, NULL, NULL), (4, '2019-03-31', 2), (5, 'default2', 2), (6, 'default2', 1), (7, 'default1', 2), (8, NULL, 2), (9, '2019-01-01', 2), (10, 'default2', 1), (11, '2019-03-31', 1), (12, NULL, 2), (13, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 0, NULL, '2018-12-31', 2, 1), (12, 1, NULL, '2023-01-01', 1, NULL), (7, 0, NULL, '2019-04-01', 1, 1), (8, NULL, NULL, '2023-01-02', 2, NULL), (0, 2, 0, '2018-12-31', NULL, 1), (2, 2, NULL, '2019-03-30', 1, NULL), (11, 2, 0, '2019-03-31', NULL, 1), (8, 2, 0, '2019-03-30', 2, 2), (NULL, NULL, NULL, '2019-04-01', 2, NULL), (6, NULL, 1, '2019-01-01', 1, NULL), (13, 0, 2, '2023-01-02', NULL, 2), (11, 1, NULL, '2018-12-31', 1, 2), (1, NULL, 2, '2019-04-01', 2, 1), (2, 1, NULL, '2019-01-02', 2, 2), (NULL, NULL, 0, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(2, '2019-01-01')
(6, 'default2')
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1;

/*
Prediction Result:
*/