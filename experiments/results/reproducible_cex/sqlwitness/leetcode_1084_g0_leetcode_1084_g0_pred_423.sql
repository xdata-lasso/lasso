-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 2), (2, 'default1', 2), (0, 'default1', 2), (3, '2019-03-31', 2), (4, '2019-03-31', NULL), (5, '2019-03-31', 1), (6, NULL, 1), (7, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 0, '2019-03-31', 2, 2), (7, 1, 0, '2018-12-31', 1, NULL), (0, 2, 0, '2019-01-01', 1, 1), (0, 1, 2, NULL, 2, 2), (NULL, 0, 1, '2018-12-31', 2, 2), (3, 1, 1, '2023-01-01', 1, 2), (5, 1, 1, '2023-01-02', 2, 1), (3, NULL, 2, '2018-12-31', 1, 2), (2, 2, 1, NULL, 1, 2), (NULL, 2, NULL, '2019-01-01', 2, NULL), (0, NULL, 0, '2019-01-02', 2, NULL), (NULL, 0, 2, '2019-01-02', NULL, 1), (4, NULL, 1, '2019-04-01', NULL, 1), (NULL, 1, 2, '2018-12-31', 1, 2), (1, 2, 2, '2019-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default1')
(1, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING COUNT(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN PRODUCT_ID END) = COUNT(1));

/*
Prediction Result:
(1, None)
*/