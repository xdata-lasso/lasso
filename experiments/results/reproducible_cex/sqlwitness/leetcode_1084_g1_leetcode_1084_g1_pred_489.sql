-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (2, 'default1', NULL), (0, 'default1', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', 1), (5, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 2, 2, '2018-12-31', 2, 1), (5, 1, 0, '2019-01-01', 1, NULL), (2, 0, NULL, NULL, NULL, 2), (4, NULL, 1, '2019-03-31', 1, 1), (4, 0, 2, '2019-01-02', 1, NULL), (NULL, 0, 1, NULL, 2, 1), (NULL, 0, NULL, '2019-01-01', NULL, NULL), (5, 0, 2, '2023-01-01', 2, NULL), (4, 2, 1, '2019-03-31', 2, 1), (0, 1, NULL, '2019-01-01', 1, NULL), (1, NULL, 2, '2019-04-01', 1, 2), (5, 1, NULL, '2023-01-02', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT A1.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT AS A1 JOIN SALES AS A2 USING (PRODUCT_ID) GROUP BY 1 HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(0, 'default1')
(4, '2019-03-31')
*/