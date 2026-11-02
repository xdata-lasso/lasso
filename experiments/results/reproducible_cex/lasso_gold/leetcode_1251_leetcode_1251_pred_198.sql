-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1014, '1975-06-06', '1975-06-07', 1015);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1023, '1978-09-09', '1978-09-10', NULL);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1028, '1979-10-10', '1979-10-11', 1026);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1014, '1975-06-06', 1016);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1023, '1978-09-09', 1025);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1023, '1979-10-10', 1027);
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
WITH T1 AS (SELECT US.PRODUCT_ID, SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN US.UNITS * P.PRICE ELSE 0 END) AS TOTAL_PRICE, SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN US.UNITS END) AS TOTAL_UNITS FROM UNITSSOLD AS US JOIN PRICES AS P ON US.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1) SELECT T1.PRODUCT_ID, ROUND(SUM(CAST(TOTAL_PRICE AS REAL) / TOTAL_UNITS), 2) AS AVERAGE_PRICE FROM T1 GROUP BY 1;

/*
Prediction Result:
(1014, 1015.0)
(1023, 0.0)
*/