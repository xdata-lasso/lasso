-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'NullSaleDateOnly', 120);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'ValidAndNullSaleDate', 220);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, NULL, 320);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 5, 15, NULL, 1, 120);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 6, 16, '2019-02-10', 1, 220);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 6, 17, NULL, 1, 220);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 7, 18, '2019-01-25', 1, 320);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(2, 'ValidAndNullSaleDate')
(3, None)
*/

-- Prediction Query
SELECT S.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S LEFT JOIN PRODUCT AS P ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY S.PRODUCT_ID HAVING NOT S.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(1, 'NullSaleDateOnly')
(2, 'ValidAndNullSaleDate')
(3, None)
*/