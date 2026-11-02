-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', 1), (-1, '2019-01-01', 1), (0, 'default1', NULL), (2, '2019-01-01', 1), (3, '2019-01-01', 1), (4, 'default2', 1), (5, 'default2', 1), (6, NULL, NULL), (7, 'default1', 1), (8, NULL, NULL), (9, NULL, NULL), (10, 'default1', 1), (11, 'default2', NULL), (12, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, -1, NULL, '2023-01-02', NULL, NULL), (11, -1, -1, '2019-01-01', 1, 1), (NULL, 1, 1, '2023-01-01', 1, NULL), (9, 1, -1, '2019-01-01', 1, NULL), (6, 1, NULL, '2019-03-30', NULL, 1), (7, -1, NULL, NULL, NULL, 1), (2, 1, 0, '2023-01-01', NULL, 1), (6, 0, 1, '2019-04-01', 1, 1), (0, NULL, 1, '2019-03-31', 1, 1), (8, 0, 0, NULL, NULL, 1), (4, 1, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default1')
(9, None)
(11, 'default2')
*/

-- Prediction Query
SELECT DISTINCT S.PRODUCT_ID, PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-01-01')) AS INTEGER) < 0 OR CAST((JULIANDAY(SALE_DATE) - JULIANDAY('2019-03-31')) AS INTEGER) > 0);

/*
Prediction Result:
*/