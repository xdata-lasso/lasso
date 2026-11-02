-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-01-01', 1), (1, 'default1', 2), (0, 'default1', NULL), (-1, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 1, '2019-04-01', 1, 2), (0, NULL, 1, '2023-01-01', 2, 2), (2, -1, 2, '2023-01-02', NULL, NULL), (1, 0, 1, '2019-03-30', 2, NULL), (NULL, 1, 1, '2019-01-01', NULL, 1), (0, NULL, 2, '2019-03-31', NULL, 1), (-1, 2, 2, '2019-03-30', 2, NULL), (2, 1, 2, '2019-03-31', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME HAVING MIN(IIF(SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 1;

/*
Prediction Result:
(-1, None)
(1, 'default1')
*/