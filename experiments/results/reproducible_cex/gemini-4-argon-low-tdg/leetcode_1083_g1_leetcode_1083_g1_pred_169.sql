-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'S8', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (11, 'S8', 950);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'iPhone', 1200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (21, 'iPhone', 1300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 101, '2020-01-01', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 2, 101, '2020-01-02', 1, 950);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 102, '2020-01-03', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (21, 3, 102, '2020-01-04', 1, 1300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (11, 2, 103, '2020-01-05', 1, 950);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(101,)
(103,)
*/

-- Prediction Query
SELECT DISTINCT S.BUYER_ID FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'S8' AND NOT S.BUYER_ID IN (SELECT DISTINCT S.BUYER_ID FROM PRODUCT AS P LEFT JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE PRODUCT_NAME = 'iPhone');

/*
Prediction Result:
*/