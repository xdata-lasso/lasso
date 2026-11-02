-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', 1), (0, NULL, NULL), (2, 'default2', 1), (3, '2019-01-01', NULL), (4, NULL, 1), (5, 'default1', 1), (6, '2019-03-31', NULL), (7, 'default1', NULL), (8, '2019-03-31', NULL), (9, NULL, NULL), (10, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-03-30', 1, 1), (1, 0, 0, NULL, 1, NULL), (9, NULL, 1, '2019-04-01', NULL, NULL), (NULL, 0, 0, '2019-04-01', 1, NULL), (0, 1, 0, '2018-12-31', 1, 1), (10, NULL, 1, NULL, NULL, 1), (3, 0, NULL, '2018-12-31', 1, NULL), (6, 0, NULL, '2023-01-02', NULL, 1), (0, 0, 1, '2019-03-31', NULL, 1), (3, 0, 1, '2019-01-02', NULL, NULL), (0, NULL, 0, '2023-01-02', NULL, 1), (1, 0, NULL, NULL, 1, NULL), (2, NULL, 0, '2019-03-30', 1, NULL), (5, 0, NULL, '2019-03-30', 1, 1), (3, NULL, NULL, NULL, NULL, 1), (NULL, NULL, 0, '2019-01-01', 1, NULL), (4, 0, NULL, '2019-01-02', 1, 1), (10, 1, 1, '2019-03-31', 1, NULL), (0, NULL, 1, '2018-12-31', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'default1')
(2, 'default2')
(4, None)
(5, 'default1')
(10, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT SALES.PRODUCT_ID, PRODUCT_NAME FROM SALES INNER JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT DISTINCT SALES.PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/