-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', NULL), (1, '2019-03-31', 1), (2, NULL, NULL), (3, 'default2', 1), (4, '2019-03-31', NULL), (5, 'default2', 1), (6, '2019-03-31', 1), (7, '2019-03-31', 1), (8, NULL, 1), (9, 'default1', NULL), (10, 'default2', 1), (11, 'default1', NULL), (12, 'default1', 1), (13, NULL, NULL), (14, 'default2', NULL), (15, 'default2', 1), (16, '2019-01-01', NULL), (17, 'default1', 1), (18, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (12, 0, 1, '2019-04-01', 1, 1), (1, NULL, NULL, NULL, 1, 1), (9, 1, 1, NULL, NULL, NULL), (3, 0, NULL, '2023-01-02', 1, 1), (2, NULL, 0, '2023-01-02', 1, NULL), (6, 0, NULL, '2019-04-01', 1, NULL), (4, 0, 1, '2018-12-31', NULL, 1), (3, 0, 0, '2019-03-31', 1, NULL), (6, 0, 1, '2019-01-01', NULL, NULL), (3, 1, NULL, '2019-03-30', 1, NULL), (15, 0, 0, NULL, NULL, NULL), (2, 0, NULL, NULL, NULL, NULL), (13, 0, NULL, '2019-03-31', NULL, 1), (10, 0, 1, NULL, 1, 1), (4, 0, 0, '2019-04-01', NULL, 1), (12, 0, NULL, '2019-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(13, None)
*/

-- Prediction Query
SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') GROUP BY A.PRODUCT_ID, B.PRODUCT_NAME;

/*
Prediction Result:
(1, '2019-03-31')
(9, 'default1')
(10, 'default2')
(13, None)
(15, 'default2')
*/