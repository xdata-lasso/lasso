-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (2, NULL, 1), (-1, '2019-01-01', NULL), (0, 'default2', NULL), (1, NULL, 1), (3, '2019-01-01', NULL), (4, NULL, 1), (5, 'default1', 2), (6, NULL, 1), (7, '2019-03-31', 2), (8, 'default2', 1), (9, NULL, NULL), (10, 'default2', 1), (11, NULL, NULL), (12, NULL, 1), (13, '2019-03-31', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 1, 0, NULL, 2, NULL), (10, 0, NULL, '2023-01-01', 2, 2), (6, 1, NULL, '2023-01-01', 2, 2), (10, -1, 0, '2019-01-02', 2, NULL), (9, 0, 1, '2019-04-01', 2, 1), (12, 1, -1, '2019-03-30', NULL, 1), (1, 2, 0, '2018-12-31', NULL, NULL), (12, NULL, 2, NULL, NULL, NULL), (13, -1, 0, '2023-01-02', NULL, 1), (11, 0, NULL, '2023-01-02', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(12, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(CASE WHEN SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
*/