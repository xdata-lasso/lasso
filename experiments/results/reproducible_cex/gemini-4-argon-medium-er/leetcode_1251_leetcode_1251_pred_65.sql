-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2020-01-01', '2020-01-31', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (1, '2020-01-01', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (1, '2020-02-01', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 1.0)
*/

-- Prediction Query
SELECT U.PRODUCT_ID, CAST(CAST(SUM(UNITS * PRICE) AS REAL) / SUM(UNITS) AS REAL(36, 2)) AS AVERAGE_PRICE FROM UNITSSOLD AS U LEFT JOIN PRICES AS P ON P.PRODUCT_ID = U.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE GROUP BY U.PRODUCT_ID;

/*
Prediction Result:
(1, 0.3333333333333333)
*/