-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1080, '1976-03-13', '1976-03-14', 1081);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1083, '1977-04-14', '1977-04-15', 1084);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1080, '1976-03-13', 1082);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1080, '1976-03-12', 1083);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1083, '1977-04-13', 1085);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1080, 1081.0)
*/

-- Prediction Query
WITH CTE AS (SELECT P.PRODUCT_ID, CASE WHEN U.PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN UNITS ELSE 0 END AS UNITS_SOLD, PRICE FROM PRICES AS P INNER JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID) SELECT PRODUCT_ID, ROUND((CAST(SUM(PRICE * UNITS_SOLD) AS REAL) / SUM(UNITS_SOLD)), 2) AS AVERAGE_PRICE FROM CTE GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1080, 1081.0)
(1083, None)
*/