-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default2', 1), (1, 'default2', NULL), (2, 'default1', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL), (5, NULL, NULL), (6, 'default2', NULL), (7, '2019-01-01', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, 1, '2019-03-30', NULL, NULL), (5, NULL, NULL, '2019-01-02', NULL, 1), (7, 0, 0, '2019-03-31', NULL, NULL), (3, NULL, NULL, '2019-03-30', NULL, NULL), (7, 1, NULL, '2019-03-31', NULL, NULL), (NULL, NULL, NULL, '2019-01-02', 1, 1), (2, 0, 0, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-03-31')
(4, '2019-03-31')
(5, None)
(7, '2019-01-01')
*/

-- Prediction Query
SELECT DISTINCT (A.PRODUCT_ID), B.PRODUCT_NAME FROM SALES AS A LEFT JOIN PRODUCT AS B ON (A.PRODUCT_ID = B.PRODUCT_ID) GROUP BY A.PRODUCT_ID HAVING MIN(A.SALE_DATE) >= '2019-01-01' AND MAX(A.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(None, None)
(3, '2019-03-31')
(4, '2019-03-31')
(5, None)
(7, '2019-01-01')
*/