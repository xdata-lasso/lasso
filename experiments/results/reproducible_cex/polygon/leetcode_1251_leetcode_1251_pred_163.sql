-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (81, '0998-01-10', '0998-01-10', 2);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (81, '0998-01-10', 2);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (81, '0998-01-11', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(81, 2.0)
*/

-- Prediction Query
SELECT T1.PRODUCT_ID, ROUND(CAST(SUM(T1.TTL_SALES) AS REAL) / T2.TTL_UNITS, 2) AS AVERAGE_PRICE FROM (SELECT P1.PRODUCT_ID, (P1.PRICE * U1.UNITS) AS TTL_SALES FROM PRICES AS P1 JOIN UNITSSOLD AS U1 ON P1.PRODUCT_ID = U1.PRODUCT_ID WHERE U1.PURCHASE_DATE BETWEEN P1.START_DATE AND P1.END_DATE) AS T1 JOIN (SELECT PRODUCT_ID, SUM(UNITS) AS TTL_UNITS FROM UNITSSOLD GROUP BY PRODUCT_ID) AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID GROUP BY T1.PRODUCT_ID;

/*
Prediction Result:
(81, 1.33)
*/