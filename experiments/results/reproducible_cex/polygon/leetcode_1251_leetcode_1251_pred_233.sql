-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (13, '1001-10-18', '1001-10-18', 2);
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (10, '0998-01-16', '0998-06-30', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (13, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, ROUND(CAST(SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN PRICE * UNITS ELSE 0 END) AS REAL) / SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN UNITS ELSE 0 END), 2) AS AVERAGE_PRICE FROM PRICES AS P JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID GROUP BY 1;

/*
Prediction Result:
(13, None)
*/