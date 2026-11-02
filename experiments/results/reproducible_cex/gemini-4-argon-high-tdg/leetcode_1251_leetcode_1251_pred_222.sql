-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2019-02-01', '2019-02-28', 5);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2019-02-01', '2019-02-28', 13);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-02-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-02-20', 15);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-03-01', 20);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-01-31', 8);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-02-10', 3);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-02-15', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 5.0)
(2, 13.0)
*/

-- Prediction Query
WITH TOTAL_UNITS AS (SELECT U1.PRODUCT_ID, SUM(UNITS) AS TU FROM UNITSSOLD AS U1 GROUP BY U1.PRODUCT_ID), TOTAL_PRICE_BY_DATE AS (SELECT P.PRODUCT_ID, CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN UNITS * PRICE ELSE 0 END AS TOTAL_COST FROM PRICES AS P JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID), TOTAL_PRICE AS (SELECT PRODUCT_ID, SUM(TOTAL_COST) AS TOTAL_COST FROM TOTAL_PRICE_BY_DATE GROUP BY PRODUCT_ID) SELECT U.PRODUCT_ID, ROUND(CAST(TOTAL_COST AS REAL) / TU, 2) AS AVERAGE_PRICE FROM TOTAL_PRICE AS P JOIN TOTAL_UNITS AS U ON P.PRODUCT_ID = U.PRODUCT_ID;

/*
Prediction Result:
(1, 2.78)
(2, 6.07)
*/