-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1014, '1975-06-06', '1975-06-07', 1015);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1023, '1978-09-09', '1978-09-10', NULL);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1014, '1975-06-06', 1016);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1023, '1978-09-09', 1025);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1014, 1015.0)
(1023, None)
*/

-- Prediction Query
WITH CTE AS (SELECT U.PRODUCT_ID, U.UNITS, CASE WHEN U.PURCHASE_DATE >= P.START_DATE AND U.PURCHASE_DATE <= P.END_DATE THEN P.PRICE END AS PRICE_DAY FROM PRICES AS P LEFT JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID) SELECT PRODUCT_ID, ROUND(CAST(SUM(UNITS * PRICE_DAY) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM CTE WHERE NOT PRICE_DAY IS NULL GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1014, 1015.0)
*/