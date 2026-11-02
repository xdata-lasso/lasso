-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'G4', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'iPhone', 1400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Nokia', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Pixel', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'UnlistedPhone', 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 101, 201, '2019-01-21', 2, 2000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 102, 202, '2019-02-17', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 103, 203, '2019-02-17', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 104, 204, '2019-06-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 105, 205, '2018-11-10', 1, 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 106, 206, '2019-01-15', 1, 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 107, 207, '2018-12-01', 3, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 108, 208, '2019-05-10', 2, 1800);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID GROUP BY P.PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31' AND COUNT(SALE_DATE) > 0;

/*
Gold Result:
(1, 'S8')
*/

-- Prediction Query
WITH P AS (SELECT PRODUCT_ID FROM PRODUCT AS P JOIN SALES USING (PRODUCT_ID) WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31') SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM P);

/*
Prediction Result:
(1, 'S8')
(6, 'UnlistedPhone')
*/