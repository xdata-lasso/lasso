-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product_name, unit_price) VALUES (1, 'default1', NULL), (0, '2019-03-31', NULL), (2, 'default1', NULL), (3, NULL, NULL), (4, '2019-03-31', 1);
INSERT INTO sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 0, NULL, '2019-01-02', 1, NULL), (1, 1, 0, '2019-04-01', NULL, 1), (1, 1, NULL, '2023-01-01', NULL, 1), (NULL, 0, 0, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(3, None)
*/

-- Prediction Query
SELECT A.PRODUCT_ID, A.PRODUCT_NAME FROM PRODUCT AS A WHERE NOT A.PRODUCT_ID IN (SELECT C.PRODUCT_ID FROM SALES AS C WHERE C.SALE_DATE > '2019-03-31' OR C.SALE_DATE < '2019-01-01');

/*
Prediction Result:
(0, '2019-03-31')
(2, 'default1')
(3, None)
(4, '2019-03-31')
*/