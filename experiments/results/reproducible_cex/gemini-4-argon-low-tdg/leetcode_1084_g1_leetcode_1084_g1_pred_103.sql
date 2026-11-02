-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Product_MultipleInQ1', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'Product_InAndBeforeQ1', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'Product_InAndAfterQ1', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Product_BeforeAndAfterQ1', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Product_AllPeriods', 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 1, 1, '2019-01-10', 2, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 2, 2, '2019-03-20', 3, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 1, '2018-11-11', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 1, 2, '2019-02-10', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 1, '2019-02-10', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 1, 2, '2019-05-01', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 1, '2018-05-01', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 1, 2, '2019-06-01', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 1, '2018-12-31', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 2, '2019-01-01', 1, 500);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 1, 3, '2019-04-01', 1, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'Product_MultipleInQ1')
*/

-- Prediction Query
WITH A AS (SELECT PRODUCT_ID, (CASE WHEN SALE_DATE >= '2019-01-01' AND SALE_DATE <= '2019-03-31' THEN 1 ELSE 0 END) AS SPRING_SALE FROM SALES), B AS (SELECT PRODUCT_ID, SUM(SPRING_SALE) AS SPRING_SALE, COUNT(*) AS TOTAL FROM A GROUP BY PRODUCT_ID HAVING SPRING_SALE <> 0 AND TOTAL = SPRING_SALE) SELECT B.PRODUCT_ID, PRODUCT.PRODUCT_NAME FROM B JOIN PRODUCT ON B.PRODUCT_ID = PRODUCT.PRODUCT_ID;

/*
Prediction Result:
*/