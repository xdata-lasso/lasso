-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'S8', 800);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'S8', 850);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'iPhone', 1000);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'iPhone', 1100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 1, '2021-03-01', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 2, '2021-03-02', 1, 850);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 3, '2021-03-03', 1, 800);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 10, 3, '2021-03-04', 1, 1100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 4, '2021-03-05', 1, 850);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 4, '2021-03-06', 1, 1000);
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
WITH CTE1 AS (SELECT S.BUYER_ID AS BOUGHTS8 FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'S8')), CTE2 AS (SELECT S.BUYER_ID AS BOUGHTIPHONE FROM SALES AS S WHERE S.PRODUCT_ID = (SELECT P.PRODUCT_ID FROM PRODUCT AS P WHERE P.PRODUCT_NAME = 'iPhone')) SELECT DISTINCT S.BUYER_ID FROM SALES AS S WHERE S.BUYER_ID IN (SELECT BOUGHTS8 FROM CTE1) AND NOT S.BUYER_ID IN (SELECT BOUGHTIPHONE FROM CTE2);

/*
Prediction Result:
(1,)
(3,)
*/