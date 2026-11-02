-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'iPhone', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (30, 'G4', 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 1, '2019-02-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 2, 1, '2019-02-02', 2, 1600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 3, 1, '2019-02-03', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 2, '2019-02-04', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 1, 2, '2019-02-05', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (30, 2, 2, '2019-02-06', 3, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 3, '2019-02-07', 2, 1600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 2, 3, '2019-02-08', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 3, 3, '2019-02-09', 1, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME IN ('S8')) AND NOT BUYER_ID IN (SELECT BUYER_ID FROM SALES WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM PRODUCT WHERE PRODUCT_NAME IN ('iPhone', 'G4')));

/*
Prediction Result:
(1,)
*/