-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (9, '0998-01-15', '0999-08-09', NULL);
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (62, '0998-01-16', '0998-06-30', NULL);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (62, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT UNITSSOLD.PRODUCT_ID, ROUND(CAST(SUM(PRICE * UNITS) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM UNITSSOLD LEFT JOIN PRICES ON PRICES.PRODUCT_ID = UNITSSOLD.PRODUCT_ID AND PRICES.START_DATE <= UNITSSOLD.PURCHASE_DATE AND UNITSSOLD.PURCHASE_DATE <= PRICES.END_DATE GROUP BY UNITSSOLD.PRODUCT_ID;

/*
Prediction Result:
(62, None)
*/