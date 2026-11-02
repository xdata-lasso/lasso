-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, 'default1', 2), (0, '2019-03-31', 2), (1, '2019-01-01', NULL), (-1, 'default2', 2), (3, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (-1, -1, 1, '2018-12-31', NULL, 2), (3, 1, -1, NULL, 1, NULL), (3, 0, 2, '2018-12-31', 2, NULL), (-1, 2, 1, '2019-03-31', NULL, 1), (2, -1, 1, '2019-03-31', NULL, 1), (3, 1, NULL, '2019-04-01', 1, NULL), (-1, 0, 0, '2023-01-01', 2, 1), (2, NULL, 2, '2019-03-30', 1, 1), (3, 1, NULL, NULL, 2, NULL), (3, -1, -1, '2019-01-02', 2, 2), (0, NULL, 1, '2019-04-01', 2, 1), (NULL, 1, -1, '2019-01-01', 2, 2), (0, 2, -1, '2023-01-02', NULL, 1), (1, 0, -1, NULL, NULL, 2), (2, NULL, 2, '2018-12-31', 1, 2), (-1, NULL, 1, '2019-04-01', 1, 2), (0, -1, 2, NULL, 2, 2), (3, -1, NULL, '2023-01-01', 1, 2), (1, 0, 0, '2019-03-31', NULL, 1), (0, 0, 1, '2019-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, '2019-01-01')
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P USING (PRODUCT_ID) GROUP BY S.PRODUCT_ID, P.PRODUCT_NAME HAVING SUM(CASE WHEN S.SALE_DATE >= '2019-01-01' AND S.SALE_DATE <= '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
*/