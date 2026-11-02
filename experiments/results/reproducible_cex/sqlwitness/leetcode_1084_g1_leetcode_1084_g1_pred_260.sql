-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-03-31', NULL), (2, '2019-03-31', NULL), (1, '2019-03-31', 3), (3, 'default1', 1), (4, 'default2', NULL), (5, 'default1', 1), (6, NULL, 1), (7, '2019-03-31', 2), (8, '2019-03-31', NULL), (9, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, NULL, 2, '2019-04-01', 3, 3), (NULL, 2, NULL, '2019-03-31', 1, 2), (7, 0, 2, '2019-01-02', 1, 2), (0, NULL, NULL, '2019-01-02', 2, NULL), (6, 3, 3, NULL, 2, NULL), (1, 2, 2, '2019-03-30', NULL, NULL), (2, 3, NULL, '2019-04-01', 1, 1), (NULL, 1, 1, NULL, 1, 2), (NULL, 0, 1, '2019-04-01', NULL, 1), (8, 1, NULL, '2023-01-02', 1, 1), (NULL, NULL, 2, '2019-01-01', 1, 1), (NULL, 0, 2, '2019-04-01', 3, NULL), (1, NULL, 2, '2018-12-31', 3, 1), (9, 1, NULL, '2019-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT S.PRODUCT_ID IN (SELECT S.PRODUCT_ID FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31') GROUP BY 1, 2 ORDER BY 1, 2, S.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(0, '2019-03-31')
(7, '2019-03-31')
(9, '2019-03-31')
*/