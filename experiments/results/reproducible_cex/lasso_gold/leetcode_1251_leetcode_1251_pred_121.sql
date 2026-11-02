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
WITH TEMP AS (SELECT A.PRODUCT_ID, PRICE, UNITS, SUM(A.PRICE * B.UNITS) AS TOT, SUM(B.UNITS) AS A FROM PRICES AS A INNER JOIN UNITSSOLD AS B USING (PRODUCT_ID) WHERE B.PURCHASE_DATE BETWEEN A.START_DATE AND A.END_DATE GROUP BY A.PRODUCT_ID) SELECT PRODUCT_ID, COALESCE(ROUND((CAST(TOT AS REAL) / A), 2), 0) AS AVERAGE_PRICE FROM TEMP GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1014, 1015.0)
(1017, 0)
*/