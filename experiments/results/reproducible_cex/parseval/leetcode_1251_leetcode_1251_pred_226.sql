-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: prices --
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2024-06-15', '2024-06-15', 247012447);

-- Inserting into table: unitssold --
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-04-30', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-11', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-03', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-12-20', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH TOTAL_UNITS AS (SELECT U1.PRODUCT_ID, SUM(UNITS) AS TU FROM UNITSSOLD AS U1 GROUP BY U1.PRODUCT_ID), TOTAL_PRICE_BY_DATE AS (SELECT P.PRODUCT_ID, CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN UNITS * PRICE ELSE 0 END AS TOTAL_COST FROM PRICES AS P JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID), TOTAL_PRICE AS (SELECT PRODUCT_ID, SUM(TOTAL_COST) AS TOTAL_COST FROM TOTAL_PRICE_BY_DATE GROUP BY PRODUCT_ID) SELECT U.PRODUCT_ID, ROUND(CAST(TOTAL_COST AS REAL) / TU, 2) AS AVERAGE_PRICE FROM TOTAL_PRICE AS P JOIN TOTAL_UNITS AS U ON P.PRODUCT_ID = U.PRODUCT_ID;

/*
Prediction Result:
(1, None)
*/