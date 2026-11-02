-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 700);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'iPhone', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, NULL, 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 's8', 700);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'iphone', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'S8 Plus', 900);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (7, 'iPhone 12', 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 10, '2022-01-01', 1, 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 10, '2022-01-02', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 20, '2022-01-03', 1, 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 30, '2022-01-04', 1, 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 30, '2022-01-05', 1, 1000);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (6, 1, 40, '2022-01-06', 1, 900);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 50, '2022-01-07', 1, 700);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (7, 1, 50, '2022-01-08', 1, 1200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT s.buyer_id FROM Sales AS s INNER JOIN Product AS p ON s.product_id = p.product_id WHERE NOT s.buyer_id IS NULL GROUP BY s.buyer_id HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;

/*
Gold Result:
(10,)
(30,)
(50,)
*/

-- Prediction Query
WITH T0 AS (SELECT S.BUYER_ID, P.PRODUCT_NAME FROM SALES AS S CROSS JOIN PRODUCT AS P WHERE S.PRODUCT_ID = P.PRODUCT_ID) SELECT BUYER_ID FROM T0 GROUP BY BUYER_ID HAVING (BUYER_ID, 'S8') IN (SELECT * FROM T0) AND NOT (BUYER_ID, 'iPhone') IN (SELECT * FROM T0);

/*
Prediction Result:
(30,)
(50,)
*/