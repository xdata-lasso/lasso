-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', 1), (0, 'default2', NULL), (2, '2019-03-31', NULL), (3, '2019-03-31', NULL), (4, '2019-03-31', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, 1, '2019-01-01', 1, 1), (0, 1, 0, '2023-01-01', 1, NULL), (NULL, NULL, 1, '2023-01-01', NULL, NULL), (4, 0, 1, NULL, NULL, 1), (1, 0, NULL, '2019-03-30', 1, 1), (NULL, 1, 1, '2018-12-31', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
SELECT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID GROUP BY A.PRODUCT_ID HAVING MIN(B.SALE_DATE) >= '2019-01-01' AND MAX(B.SALE_DATE) <= '2019-03-31';

/*
Prediction Result:
(1, 'default2')
(3, '2019-03-31')
*/