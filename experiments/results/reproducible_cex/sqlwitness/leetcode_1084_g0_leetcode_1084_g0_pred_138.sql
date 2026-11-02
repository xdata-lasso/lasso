-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, 'default2', 1), (2, '2019-01-01', 1), (3, NULL, 1), (4, 'default2', NULL), (5, 'default2', 1), (6, NULL, 1), (7, 'default2', NULL), (8, '2019-01-01', 1), (9, '2019-03-31', NULL), (10, 'default1', 1), (11, 'default2', 1), (12, NULL, NULL), (13, 'default2', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 0, 1, '2019-01-01', 1, 1), (13, 0, 1, '2019-03-31', 1, 1), (6, 0, 0, NULL, NULL, NULL), (12, NULL, 1, '2018-12-31', 1, 1), (12, 1, NULL, '2023-01-01', 1, NULL), (NULL, 0, 0, NULL, NULL, 1), (12, 1, 0, '2023-01-01', 1, NULL), (13, 0, 1, '2019-03-30', NULL, 1), (NULL, NULL, 1, '2023-01-01', NULL, NULL), (0, NULL, 0, '2019-01-01', NULL, 1), (12, 0, NULL, '2023-01-01', 1, NULL), (1, 0, NULL, '2019-03-30', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, '2019-01-01')
(1, 'default2')
(13, 'default2')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE (A.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') AND NOT A.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/