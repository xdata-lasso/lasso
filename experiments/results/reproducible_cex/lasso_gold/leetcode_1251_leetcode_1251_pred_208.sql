-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1014, '1975-06-06', '1975-06-07', 1015);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1017, '1976-07-07', '1976-07-08', 1018);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1014, '1975-06-06', 1016);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1017, '1976-07-07', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1014, 1015.0)
(1017, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, COALESCE(ROUND(CAST(SUM(PRICE * UNITS) AS REAL) / SUM(UNITS), 2), 0) AS AVERAGE_PRICE FROM PRICES JOIN UNITSSOLD USING (PRODUCT_ID) WHERE PURCHASE_DATE BETWEEN START_DATE AND END_DATE GROUP BY PRODUCT_ID ORDER BY PRODUCT_ID, AVERAGE_PRICE NULLS LAST;

/*
Prediction Result:
(1014, 1015.0)
(1017, 0)
*/