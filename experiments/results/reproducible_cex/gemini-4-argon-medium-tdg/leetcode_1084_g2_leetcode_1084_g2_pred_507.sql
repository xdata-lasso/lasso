-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'Duplicate Name', 150);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'Duplicate Name', 250);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (30, 'Multiple Valid Sales', 350);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (40, 'Unsold Product', 450);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 2, '2019-02-01', 1, 150);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 1, 2, '2019-05-01', 1, 250);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 1, 2, '2019-01-15', 1, 350);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 2, 3, '2019-02-15', 2, 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 3, 4, '2019-03-15', 1, 350);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(10, 'Duplicate Name')
(30, 'Multiple Valid Sales')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT P.PRODUCT_ID FROM SALES AS S INNER JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT S.SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(10, 'Duplicate Name')
(30, 'Multiple Valid Sales')
(40, 'Unsold Product')
*/