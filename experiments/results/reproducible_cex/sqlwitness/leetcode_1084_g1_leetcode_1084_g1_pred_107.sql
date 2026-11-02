-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (-1, NULL, NULL), (2, '2019-01-01', 2), (0, NULL, 1), (3, 'default2', 1), (4, NULL, 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 1, 0, NULL, 1, NULL), (-1, -1, NULL, '2019-03-31', 2, NULL), (3, 2, NULL, '2023-01-02', 2, 1), (4, NULL, 0, '2019-04-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, None)
(-1, None)
*/

-- Prediction Query
WITH MAIN AS (SELECT PRODUCT_ID, PRODUCT_NAME, (CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS DATES, (CASE WHEN NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 1 ELSE 0 END) AS NON_DATES FROM SALES INNER JOIN PRODUCT USING (PRODUCT_ID)) SELECT PRODUCT_ID, PRODUCT_NAME FROM MAIN GROUP BY PRODUCT_ID HAVING SUM(DATES) > 0 AND SUM(NON_DATES) = 0;

/*
Prediction Result:
(-1, None)
*/