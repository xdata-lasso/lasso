-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2020-01-01', '2020-01-31', NULL);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (1, '2020-01-15', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, COALESCE(ROUND(CAST(SUM(TEMP_SUM) AS REAL) / SUM(UNITS), 2), 0) AS AVERAGE_PRICE FROM (SELECT P1.PRODUCT_ID, (P1.PRICE * U1.UNITS) AS TEMP_SUM, U1.UNITS FROM PRICES AS P1 JOIN UNITSSOLD AS U1 ON P1.PRODUCT_ID = U1.PRODUCT_ID AND U1.PURCHASE_DATE BETWEEN P1.START_DATE AND P1.END_DATE) AS A GROUP BY A.PRODUCT_ID;

/*
Prediction Result:
(1, 0)
*/