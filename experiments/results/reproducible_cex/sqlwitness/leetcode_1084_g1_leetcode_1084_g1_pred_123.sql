-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (0, '2019-01-01', 1), (1, NULL, NULL), (2, '2019-01-01', NULL), (3, '2019-01-01', 1), (4, '2019-01-01', 1), (5, NULL, NULL), (6, '2019-01-01', NULL), (7, 'default2', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, NULL, NULL, '2018-12-31', 1, 1), (6, 0, NULL, '2019-01-02', NULL, NULL), (0, 1, NULL, '2023-01-02', 1, 1), (3, 1, NULL, NULL, NULL, NULL), (6, NULL, 0, NULL, NULL, NULL), (1, 1, 1, '2023-01-02', 1, NULL), (7, NULL, 1, '2019-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(6, '2019-01-01')
(3, '2019-01-01')
(7, 'default2')
*/

-- Prediction Query
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM PRODUCT WHERE PRODUCT.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31') AND NOT PRODUCT.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(6, '2019-01-01')
(7, 'default2')
*/