-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default2', 3), (0, '2019-01-01', 3), (3, 'default1', 2), (1, 'default2', 3), (4, 'default1', 1), (5, '2019-03-31', NULL), (6, NULL, NULL), (7, '2019-03-31', 3);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 3, '2019-04-01', 1, 2), (1, 1, 0, '2019-01-02', NULL, 1), (NULL, NULL, 1, NULL, 2, NULL), (0, 3, 0, NULL, 2, 2), (NULL, NULL, 3, '2023-01-02', 1, 1), (3, 3, 2, '2019-01-01', NULL, 2), (3, 1, 2, '2019-01-01', 3, NULL), (4, 1, 3, '2023-01-01', 2, 1), (NULL, 0, 2, NULL, 2, 3), (7, 0, 3, '2019-03-30', NULL, NULL), (3, NULL, 1, '2019-03-30', 2, 3), (4, 1, 0, '2023-01-02', 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1, 2 HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' ORDER BY 1, S.PRODUCT_ID NULLS LAST, P.PRODUCT_NAME NULLS LAST;

/*
Prediction Result:
(1, 'default2')
(3, 'default1')
(7, '2019-03-31')
*/