-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, 'default1', 2), (1, NULL, 1), (2, 'default2', 2), (3, '2019-01-01', 1), (4, '2019-01-01', 2), (5, NULL, 2), (6, 'default2', 1), (7, 'default2', NULL), (8, '2019-03-31', 1), (9, NULL, 1), (10, 'default2', 2), (11, '2019-01-01', NULL), (12, '2019-01-01', 1), (13, 'default1', 1), (14, '2019-03-31', 2), (15, '2019-03-31', 2), (16, 'default2', 1), (17, 'default1', 1), (18, 'default1', 2), (19, 'default2', 1), (20, '2019-03-31', NULL), (21, NULL, 2), (22, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 2, 1, '2019-01-02', 2, 1), (17, NULL, 2, '2019-03-31', NULL, 1), (18, 2, 0, '2019-04-01', 2, NULL), (8, 0, 0, '2019-03-30', NULL, NULL), (3, NULL, 2, NULL, 2, NULL), (8, 0, 1, '2023-01-02', 1, 2), (19, NULL, NULL, '2018-12-31', 2, 2), (11, 1, 0, NULL, 1, 2), (22, 0, NULL, '2019-04-01', 1, 1), (4, 1, NULL, '2019-03-31', 2, 1), (21, 1, 0, '2019-03-31', NULL, 2), (11, 2, 2, '2019-03-31', 2, NULL), (5, NULL, NULL, NULL, 1, 1), (6, 1, 0, '2023-01-01', 2, NULL), (15, 2, 0, '2019-01-02', 2, NULL), (16, 2, 2, '2019-03-30', 2, 1), (1, 1, 0, '2019-01-01', 2, NULL), (20, 0, 0, '2018-12-31', NULL, NULL), (6, NULL, 1, '2018-12-31', NULL, 1), (12, 0, 0, '2023-01-01', 2, 2), (16, 0, NULL, '2023-01-02', 1, 1), (20, 2, NULL, '2019-03-30', 1, 2), (18, 0, 1, '2019-04-01', NULL, 2), (20, NULL, 2, NULL, 2, 1), (12, 0, 0, '2019-04-01', 2, NULL), (6, 1, 0, NULL, NULL, 2), (6, 1, 1, '2019-01-02', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(17, 'default1')
(3, '2019-01-01')
(11, '2019-01-01')
(4, '2019-01-01')
(21, None)
(5, None)
(15, '2019-03-31')
(1, None)
*/

-- Prediction Query
SELECT P.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT P.PRODUCT_ID IN (SELECT DISTINCT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') GROUP BY 1;

/*
Prediction Result:
(1, None)
(4, '2019-01-01')
(11, '2019-01-01')
(15, '2019-03-31')
(17, 'default1')
(21, None)
*/