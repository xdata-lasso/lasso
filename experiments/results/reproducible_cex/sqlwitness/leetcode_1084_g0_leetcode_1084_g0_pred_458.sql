-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, '2019-01-01', NULL), (0, '2019-01-01', NULL), (2, 'default2', 1), (3, 'default1', 1), (4, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 0, '2019-01-01', NULL, 1), (4, 0, 0, '2019-03-30', NULL, 1), (0, 0, 0, '2019-03-31', NULL, 1), (NULL, NULL, NULL, '2019-01-01', NULL, 1), (NULL, NULL, NULL, '2019-01-02', 1, 1), (4, NULL, 1, '2019-03-31', NULL, 1), (3, NULL, 0, NULL, 1, 1), (4, 0, 1, NULL, 1, 1), (2, NULL, 1, '2019-04-01', NULL, 1), (2, NULL, 1, '2019-03-30', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(0, '2019-01-01')
(4, '2019-03-31')
*/

-- Prediction Query
SELECT SALES.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM SALES LEFT JOIN PRODUCT ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID GROUP BY PRODUCT.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(None, None)
(0, '2019-01-01')
(4, '2019-03-31')
*/