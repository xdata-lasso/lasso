-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'Product_MidQ1', 100);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (2, 'Product_StartQ1', 200);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (3, 'Product_EndQ1', 300);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (4, 'Product_BeforeQ1', 400);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (5, 'Product_AfterQ1', 500);
INSERT INTO Product (product_id, product_name, unit_price) VALUES (6, 'Product_NoSales', 600);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 20, '2019-02-15', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (2, 10, 20, '2019-01-01', 1, 200);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (3, 10, 20, '2019-03-31', 1, 300);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (4, 10, 20, '2018-12-31', 1, 400);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (5, 10, 20, '2019-04-01', 1, 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
(1, 'Product_MidQ1')
(2, 'Product_StartQ1')
(3, 'Product_EndQ1')
*/

-- Prediction Query
SELECT PRODUCT_ID, PRODUCT_NAME FROM PRODUCT WHERE NOT PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE NOT SALE_DATE BETWEEN '2019-01-01' AND '2019-04-01');

/*
Prediction Result:
(1, 'Product_MidQ1')
(2, 'Product_StartQ1')
(3, 'Product_EndQ1')
(5, 'Product_AfterQ1')
(6, 'Product_NoSales')
*/