-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, NULL, 1), (0, 'default2', 1), (2, '2019-01-01', 2);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 0, NULL, '2019-04-01', NULL, 2), (0, 2, 0, NULL, 2, NULL), (NULL, 2, 1, NULL, NULL, 1), (0, 1, 2, '2019-01-02', NULL, 2), (0, 0, 1, '2019-03-31', NULL, NULL), (1, 2, 0, '2018-12-31', NULL, NULL), (2, 0, 1, '2019-04-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, 'default2')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S USING (PRODUCT_ID) GROUP BY PRODUCT_ID HAVING SUM(CASE WHEN S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' THEN 0 ELSE 1 END) = 0;

/*
Prediction Result:
*/