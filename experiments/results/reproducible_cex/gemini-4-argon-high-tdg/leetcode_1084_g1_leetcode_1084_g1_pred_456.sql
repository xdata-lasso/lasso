-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'G4', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'iPhone', 1400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Pixel', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Nokia', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'UnsoldPhone', 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 101, 201, '2019-02-15', 2, 2000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 102, 202, '2019-01-15', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 103, 203, '2018-11-10', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 104, 204, '2019-03-10', 1, 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 105, 205, '2019-05-20', 1, 1400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 106, 206, '2018-06-01', 3, 2700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 107, 207, '2019-08-01', 2, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'S8')
*/

-- Prediction Query
SELECT T.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P JOIN (SELECT PRODUCT_ID FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01' OR SALE_DATE > '2019-03-31')) AS T ON T.PRODUCT_ID = P.PRODUCT_ID;

/*
Prediction Result:
(1, 'S8')
(6, 'UnsoldPhone')
*/