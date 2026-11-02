-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, NULL, 1), (2, 'default1', NULL), (3, 'default1', NULL), (4, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (0, 0, NULL, NULL, 1, NULL), (4, 1, NULL, '2019-01-01', NULL, 1), (3, NULL, NULL, '2023-01-02', 1, NULL), (1, 1, 1, '2023-01-01', NULL, 1), (1, NULL, NULL, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(0, None)
(4, '2019-03-31')
*/

-- Prediction Query
SELECT DISTINCT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A INNER JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT (A.PRODUCT_ID, A.PRODUCT_NAME) IN (SELECT DISTINCT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A INNER JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(4, '2019-03-31')
*/