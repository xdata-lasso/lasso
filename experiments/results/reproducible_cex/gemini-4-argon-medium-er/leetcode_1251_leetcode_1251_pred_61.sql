-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2023-01-01', '2023-01-10', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-01-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-02-01', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
WITH TOTAL_UNITS AS (SELECT U1.PRODUCT_ID, SUM(U1.UNITS) AS TOTAL_UNITS FROM UNITSSOLD AS U1 GROUP BY U1.PRODUCT_ID), TOTAL_DAILY_REVENUE AS (SELECT P.PRODUCT_ID, U2.PURCHASE_DATE, (P.PRICE * U2.UNITS) AS TOTAL_DAILY_REVENUE FROM PRICES AS P INNER JOIN UNITSSOLD AS U2 ON P.PRODUCT_ID = U2.PRODUCT_ID WHERE U2.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE), TOTAL_REVENUE AS (SELECT TOTAL_DAILY_REVENUE.PRODUCT_ID, SUM(TOTAL_DAILY_REVENUE.TOTAL_DAILY_REVENUE) AS TOTAL_REVENUE FROM TOTAL_DAILY_REVENUE GROUP BY TOTAL_DAILY_REVENUE.PRODUCT_ID) SELECT TOTAL_UNITS.PRODUCT_ID, ROUND((CAST(TOTAL_REVENUE.TOTAL_REVENUE AS REAL) / TOTAL_UNITS.TOTAL_UNITS), 2) AS AVERAGE_PRICE FROM TOTAL_UNITS JOIN TOTAL_REVENUE ON TOTAL_UNITS.PRODUCT_ID = TOTAL_REVENUE.PRODUCT_ID;

/*
Prediction Result:
(1, 5.0)
*/