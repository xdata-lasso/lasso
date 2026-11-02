-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', NULL), (1, 'default2', 1), (2, 'default1', 1), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL), (5, NULL, 1), (6, 'default2', 1), (7, NULL, 1), (8, 'default2', 1), (9, 'default2', NULL), (10, '2019-01-01', NULL), (11, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 0, '2019-01-01', NULL, NULL), (10, NULL, NULL, '2019-01-02', NULL, NULL), (10, 0, NULL, '2023-01-02', NULL, NULL), (1, 0, 0, '2023-01-01', 1, NULL), (NULL, 0, NULL, '2023-01-01', NULL, 1), (7, 1, 1, '2019-01-02', 1, NULL), (7, 1, 0, '2019-03-31', NULL, NULL), (4, NULL, 0, '2019-01-01', 1, NULL), (8, 0, 1, '2023-01-01', 1, 1), (NULL, 0, 0, '2019-03-30', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-03-31')
(4, '2019-03-31')
(7, None)
*/

-- Prediction Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
*/