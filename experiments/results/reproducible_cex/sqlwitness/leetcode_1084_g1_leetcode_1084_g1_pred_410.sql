-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, '2019-01-01', 2), (-1, 'default2', NULL), (1, '2019-01-01', NULL), (0, 'default1', NULL), (3, 'default2', 2), (4, '2019-03-31', NULL), (5, 'default1', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, 2, '2023-01-02', 2, 2), (5, -1, 0, '2023-01-02', 2, 2), (5, 0, 0, '2019-03-30', NULL, 1), (5, 0, 1, '2019-01-01', 2, 2), (NULL, 0, -1, '2023-01-01', 1, 1), (3, 0, NULL, '2019-03-31', 1, 1), (0, 0, 1, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(IIF(NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31', 1, 0)) = 0;

/*
Prediction Result:
(3, 'default2')
*/