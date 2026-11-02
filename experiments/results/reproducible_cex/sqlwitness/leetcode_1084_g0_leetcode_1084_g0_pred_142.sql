-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, NULL, NULL), (2, '2019-03-31', NULL), (3, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, NULL, 1, '2018-12-31', NULL, 1), (3, NULL, NULL, '2018-12-31', 1, NULL), (1, 0, NULL, '2019-03-30', NULL, NULL), (0, 1, NULL, '2019-01-01', NULL, 1), (3, 1, NULL, '2019-04-01', NULL, 1), (3, 1, 0, '2019-03-30', 1, 1), (2, 0, NULL, '2019-01-02', NULL, 1), (2, NULL, 1, '2019-03-30', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, None)
(1, '2019-01-01')
(2, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, PRODUCT_NAME FROM SALES AS A JOIN PRODUCT AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') AND NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01');

/*
Prediction Result:
*/