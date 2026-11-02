-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (9, '0998-06-17', '0999-08-09', 1);
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (12, '0998-01-16', '1002-06-11', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (12, '1002-06-11', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(12, None)
*/

-- Prediction Query
SELECT PRICES.PRODUCT_ID, IIF(NOT SUM(UNITSSOLD.UNITS) IS NULL, ROUND(CAST(SUM(UNITSSOLD.UNITS * PRICES.PRICE) AS REAL) / SUM(UNITSSOLD.UNITS), 2), 0) AS AVERAGE_PRICE FROM PRICES LEFT JOIN UNITSSOLD ON PRICES.PRODUCT_ID = UNITSSOLD.PRODUCT_ID AND UNITSSOLD.PURCHASE_DATE BETWEEN PRICES.START_DATE AND PRICES.END_DATE GROUP BY PRICES.PRODUCT_ID;

/*
Prediction Result:
(9, 0)
(12, 0)
*/