-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (14, '0998-06-17', '0999-12-30', NULL);
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (15, '0999-12-29', '0999-12-29', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (14, '0999-12-29', 8299);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (15, '0999-12-30', 8298);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(14, None)
*/

-- Prediction Query
SELECT PRODUCT_ID, ROUND(CAST(TOTAL_SALES AS REAL) / TOTAL_UNITS, 2) AS AVERAGE_PRICE FROM (SELECT U.PRODUCT_ID, SUM(U.UNITS * P.PRICE) AS TOTAL_SALES, SUM(U.UNITS) AS TOTAL_UNITS FROM UNITSSOLD AS U LEFT JOIN PRICES AS P ON U.PRODUCT_ID = P.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE GROUP BY 1) AS SUB;

/*
Prediction Result:
(14, None)
(15, None)
*/