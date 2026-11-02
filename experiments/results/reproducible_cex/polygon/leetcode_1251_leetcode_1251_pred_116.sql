-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (16, '1001-10-19', '1001-10-19', NULL);
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (13, '1001-10-17', '1001-10-17', NULL);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (16, '1001-10-19', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (13, '1001-10-18', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(16, None)
*/

-- Prediction Query
WITH CTE AS (SELECT P.PRODUCT_ID, PRICE, UNITS, (PRICE * UNITS) AS TOTAL_PRICE FROM PRICES AS P LEFT JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE) SELECT DISTINCT PRODUCT_ID, ROUND(CAST(SUM(TOTAL_PRICE) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM CTE GROUP BY PRODUCT_ID;

/*
Prediction Result:
(13, None)
(16, None)
*/