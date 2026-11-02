-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default2', NULL), (0, 'default2', NULL), (2, NULL, NULL), (3, NULL, 1), (4, '2019-01-01', NULL);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 0, 1, NULL, NULL, NULL), (0, 0, 1, '2019-03-30', 1, NULL), (3, NULL, 0, '2023-01-02', NULL, 1), (3, 0, NULL, '2019-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(4, '2019-01-01')
(0, 'default2')
*/

-- Prediction Query
SELECT DISTINCT SALES.PRODUCT_ID, PRODUCT_NAME FROM PRODUCT INNER JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31' AND NOT SALES.PRODUCT_ID IN (SELECT DISTINCT SALES.PRODUCT_ID FROM PRODUCT INNER JOIN SALES ON PRODUCT.PRODUCT_ID = SALES.PRODUCT_ID WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31');

/*
Prediction Result:
(0, 'default2')
*/