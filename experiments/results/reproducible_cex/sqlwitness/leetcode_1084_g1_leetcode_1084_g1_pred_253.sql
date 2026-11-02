-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, NULL, NULL), (-1, 'default1', 1), (2, NULL, NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 0, '2023-01-01', 2, 2), (1, 0, 2, '2019-04-01', NULL, 2), (NULL, 2, 1, '2019-03-31', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) >= 1 AND SUM(CASE WHEN NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(None, None)
*/