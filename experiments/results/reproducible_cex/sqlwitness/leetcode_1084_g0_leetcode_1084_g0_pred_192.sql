-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-03-31', NULL), (0, 'default2', 1), (2, 'default1', 1), (3, '2019-03-31', NULL), (4, 'default2', 1), (5, NULL, 1), (6, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 1, '2019-01-01', 1, NULL), (5, 1, 1, '2019-01-02', NULL, NULL), (5, 1, NULL, NULL, 1, 1), (3, 1, 0, '2019-03-30', 1, NULL), (6, 1, 1, '2019-01-02', 1, 1), (6, NULL, NULL, '2018-12-31', NULL, NULL), (6, 0, 1, '2019-03-31', NULL, NULL), (5, 1, 1, '2018-12-31', 1, 1), (6, 0, 1, '2019-01-02', 1, 1), (NULL, NULL, 0, '2019-04-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(3, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT SALES.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
*/