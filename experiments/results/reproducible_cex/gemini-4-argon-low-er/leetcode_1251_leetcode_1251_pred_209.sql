-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', 'invalid_date', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-01-01', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
WITH TBL AS (SELECT PRODUCT_ID, SUM(PRICE * UNITS) AS COST, SUM(UNITS) AS UNITS FROM PRICES INNER JOIN UNITSSOLD USING (PRODUCT_ID) WHERE PURCHASE_DATE BETWEEN START_DATE AND END_DATE AND DATE(PURCHASE_DATE) <= DATE(END_DATE) GROUP BY PRODUCT_ID) SELECT PRODUCT_ID, ROUND((CAST(COST AS REAL) / UNITS), 2) AS AVERAGE_PRICE FROM TBL;

/*
Prediction Result:
*/