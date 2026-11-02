-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 3), (3, 'default1', 3), (-1, NULL, NULL), (2, 'default2', NULL), (1, 'default2', NULL), (4, 'default1', 1), (5, '2019-01-01', 3), (6, '2019-03-31', 3), (7, 'default1', 1), (8, 'default1', 3), (9, NULL, 2), (10, 'default2', 1), (11, 'default2', 2), (12, 'default2', 2), (13, 'default2', 3), (14, '2019-03-31', NULL), (15, NULL, 3), (16, 'default1', 3), (17, 'default1', NULL), (18, 'default1', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 2, 2, '2023-01-01', 1, 1), (11, NULL, 2, '2018-12-31', NULL, 1), (1, 3, 3, '2023-01-01', NULL, 2), (12, 2, 0, '2019-04-01', 3, 1), (18, 2, NULL, '2019-01-01', 3, NULL), (5, 1, 3, '2019-03-31', 2, 3), (-1, 0, 0, '2023-01-01', NULL, NULL), (15, 2, -1, '2019-03-31', 3, 3), (7, 1, -1, NULL, 1, 1), (4, -1, 2, '2019-03-31', 3, 1), (12, 3, 2, '2019-03-31', 1, NULL), (13, 0, 0, '2019-03-31', 3, 3), (13, NULL, 3, '2019-04-01', 1, NULL), (17, 1, 2, '2019-01-01', 2, 3), (5, 3, -1, '2018-12-31', 2, 2), (0, 3, 1, '2019-04-01', 3, 3), (NULL, NULL, 2, '2023-01-02', NULL, 1), (0, 2, 2, '2019-01-02', 1, 3), (17, NULL, 3, '2019-04-01', 1, 3), (5, 0, 3, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(15, None)
(18, 'default1')
*/

-- Prediction Query
SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY 1, 2 HAVING SUM(CASE WHEN SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(7, 'default1')
(15, None)
(18, 'default1')
*/