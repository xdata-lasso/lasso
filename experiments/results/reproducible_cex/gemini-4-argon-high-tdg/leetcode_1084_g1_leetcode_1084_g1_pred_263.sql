-- Schema DDL
CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(255), "unit_price" INTEGER, CHECK ("unit_price" > 0));

CREATE TABLE "Sales" ("product_id" INTEGER, "seller_id" INTEGER, "buyer_id" INTEGER, "sale_date" DATE, "quantity" INTEGER, "price" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), CHECK ("quantity" > 0), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 9
INSERT INTO Product (product_id, product_name, unit_price) VALUES (1, 'ValidQ1WithNullProductSale', 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (1, 10, 20, '2019-02-10', 1, 100);
INSERT INTO Sales (product_id, seller_id, buyer_id, sale_date, quantity, price) VALUES (NULL, 11, 21, '2018-05-01', 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT P.PRODUCT_ID, P.PRODUCT_NAME FROM SALES AS S JOIN PRODUCT AS P ON S.PRODUCT_ID = P.PRODUCT_ID WHERE NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE < '2019-01-01') AND NOT P.PRODUCT_ID IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE > '2019-03-31');

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT A.PRODUCT_ID, A.PRODUCT_NAME, B.SALE_DATE, B.QUANTITY FROM PRODUCT AS A LEFT JOIN SALES AS B ON A.PRODUCT_ID = B.PRODUCT_ID) SELECT PRODUCT_ID, PRODUCT_NAME FROM (SELECT PRODUCT_ID, PRODUCT_NAME, SUM(CASE WHEN SALE_DATE >= DATE('2019-01-01') AND SALE_DATE <= ('2019-03-31') THEN QUANTITY ELSE 0 END) AS SPRING_19_SALES, SUM(CASE WHEN SALE_DATE < DATE('2019-01-01') OR SALE_DATE > ('2019-03-31') THEN QUANTITY ELSE 0 END) AS OTHER_SALES FROM CTE GROUP BY PRODUCT_ID) AS C WHERE SPRING_19_SALES > 0 AND OTHER_SALES = 0;

/*
Prediction Result:
(1, 'ValidQ1WithNullProductSale')
*/