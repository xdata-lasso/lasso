-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests handling of NULLs (e.g., NULL sale_date in Sales, duplicate product_name in Product) and wrong join conditions (e.g., joining on seller_id or buyer_id instead of product_id).
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Same_Name', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'Same_Name', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'Null_Date_Only', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Null_And_Valid_Date', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'ID_Collision_Target', 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 5, 5, '2019-02-01', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 5, 5, '2019-02-05', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, NULL, 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 1, NULL, 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 1, '2019-02-15', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 1, '2019-05-01', 1, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT P.PRODUCT_ID, P.PRODUCT_NAME FROM PRODUCT AS P INNER JOIN (SELECT PRODUCT_ID FROM SALES GROUP BY PRODUCT_ID HAVING MIN(SALE_DATE) >= '2019-01-01' AND MAX(SALE_DATE) <= '2019-03-31') AS S ON (P.PRODUCT_ID = S.PRODUCT_ID);

/*
Gold Result:
(1, 'Same_Name')
(2, 'Same_Name')
(4, 'Null_And_Valid_Date')
*/

-- Prediction Query
SELECT A.PRODUCT_ID, B.PRODUCT_NAME FROM SALES AS A CROSS JOIN PRODUCT AS B WHERE A.PRODUCT_ID = B.PRODUCT_ID AND NOT A.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31' OR SALE_DATE < '2019-01-01') GROUP BY A.PRODUCT_ID, B.PRODUCT_NAME;

/*
Prediction Result:
(1, 'Same_Name')
(2, 'Same_Name')
(3, 'Null_Date_Only')
(4, 'Null_And_Valid_Date')
*/