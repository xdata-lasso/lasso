-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: prices --
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2024-06-15', '2024-06-15', 247012447);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (2, '2025-06-17', '2021-11-08', 247012447);

-- Inserting into table: unitssold --
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-04-30', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-11', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-03', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-12-20', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-02-11', 809183447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT US.PRODUCT_ID, SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN US.UNITS * P.PRICE ELSE 0 END) AS TOTAL_PRICE, SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN US.UNITS END) AS TOTAL_UNITS FROM UNITSSOLD AS US JOIN PRICES AS P ON US.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1) SELECT T1.PRODUCT_ID, ROUND(SUM(CAST(TOTAL_PRICE AS REAL) / TOTAL_UNITS), 2) AS AVERAGE_PRICE FROM T1 GROUP BY 1;

/*
Prediction Result:
(1, None)
(2, None)
*/