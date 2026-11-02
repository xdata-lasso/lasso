-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1007, '1972-03-03', '1972-03-04', 1010);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1010, '1973-04-04', '1972-03-04', 1013);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1007, '1972-03-03', 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1007, 1010.0)
*/

-- Prediction Query
SELECT PRICES.PRODUCT_ID, ROUND(CAST(SUM(UNITSSOLD.UNITS * PRICES.PRICE) AS REAL) / SUM(UNITSSOLD.UNITS), 2) AS AVERAGE_PRICE FROM PRICES LEFT JOIN UNITSSOLD ON PRICES.PRODUCT_ID = UNITSSOLD.PRODUCT_ID AND UNITSSOLD.PURCHASE_DATE BETWEEN PRICES.START_DATE AND PRICES.END_DATE GROUP BY PRICES.PRODUCT_ID;

/*
Prediction Result:
(1007, 1010.0)
(1010, None)
*/