-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (61, '0998-01-16', '0998-06-30', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT PRICES.PRODUCT_ID, ROUND(CAST(SUM(PRICES.PRICE * UNITSSOLD.UNITS) AS REAL) / SUM(UNITSSOLD.UNITS), 2) AS AVERAGE_PRICE FROM PRICES LEFT JOIN UNITSSOLD ON PRICES.PRODUCT_ID = UNITSSOLD.PRODUCT_ID AND PRICES.START_DATE <= UNITSSOLD.PURCHASE_DATE AND UNITSSOLD.PURCHASE_DATE <= PRICES.END_DATE GROUP BY PRICES.PRODUCT_ID;

/*
Prediction Result:
(61, None)
*/