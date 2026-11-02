-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, NULL, 1), (2, 'default2', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', 1), (5, '2019-03-31', NULL), (6, NULL, NULL), (7, '2019-01-01', 1), (8, 'default1', NULL), (9, NULL, NULL), (10, '2019-03-31', NULL), (11, NULL, 1), (12, '2019-03-31', NULL), (13, '2019-03-31', 1), (14, '2019-03-31', NULL), (15, 'default1', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (13, 0, 0, '2019-03-31', 1, 1), (7, 1, 1, '2023-01-02', NULL, 1), (NULL, NULL, 0, '2019-03-30', 1, NULL), (10, NULL, 1, '2018-12-31', NULL, 1), (8, 1, NULL, NULL, 1, NULL), (2, 1, NULL, '2019-03-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(13, '2019-03-31')
(8, 'default1')
(2, 'default2')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A INNER JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE B.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01');

/*
Prediction Result:
(13, '2019-03-31')
(2, 'default2')
*/