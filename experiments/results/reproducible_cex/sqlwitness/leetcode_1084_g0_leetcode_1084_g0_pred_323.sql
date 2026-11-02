-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, NULL), (0, NULL, 1), (2, NULL, 1), (3, 'default1', NULL), (4, 'default1', NULL), (5, 'default1', NULL), (6, '2019-01-01', 1), (7, '2019-01-01', NULL), (8, 'default2', 1), (9, '2019-03-31', NULL), (10, 'default1', 1), (11, NULL, 1), (12, 'default2', NULL), (13, NULL, NULL), (14, 'default1', NULL), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, NULL, 0, '2019-01-02', 1, 1), (10, NULL, 1, '2023-01-02', NULL, 1), (NULL, 1, NULL, '2019-01-02', 1, NULL), (15, 1, 1, '2023-01-01', NULL, 1), (3, 1, 1, '2019-03-31', 1, 1), (2, 1, 1, '2023-01-01', 1, NULL), (6, 1, 0, '2023-01-02', NULL, NULL), (10, NULL, 0, '2019-03-30', 1, NULL), (4, NULL, NULL, '2019-03-30', 1, NULL), (6, 1, 0, '2018-12-31', 1, NULL), (2, NULL, 0, '2019-03-31', NULL, 1), (11, 1, 0, '2018-12-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, None)
(3, 'default1')
(4, 'default1')
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID GROUP BY SALES.PRODUCT_ID HAVING MAX(SALES.SALE_DATE) <= '2019-03-31' AND MIN(SALES.SALE_DATE) >= '2019-01-01';

/*
Prediction Result:
(None, None)
(0, None)
(3, 'default1')
(4, 'default1')
*/