-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (10, 'Laptop', 1200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (20, 'Monitor', 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 1, '2019-01-05', 1, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 2, 2, '2019-02-14', 2, 2400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (10, 1, 3, '2019-03-25', 1, 1200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 4, 4, '2019-01-15', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (20, 4, 4, '2019-01-15', 1, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(10, 'Laptop')
(20, 'Monitor')
*/

-- Prediction Query
SELECT * FROM PRODUCT AS P JOIN SALES AS S ON P.PRODUCT_ID = S.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-03-31');

/*
Prediction Result:
(10, 'Laptop', 1200, 10, 1, 1, '2019-01-05', 1, 1200)
(10, 'Laptop', 1200, 10, 2, 2, '2019-02-14', 2, 2400)
(10, 'Laptop', 1200, 10, 1, 3, '2019-03-25', 1, 1200)
(20, 'Monitor', 300, 20, 4, 4, '2019-01-15', 1, 300)
(20, 'Monitor', 300, 20, 4, 4, '2019-01-15', 1, 300)
*/