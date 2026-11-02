-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2020-01-01', '2020-01-31', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT P.PRODUCT_ID AS PRODUCT_ID, S.UNITS AS QUANTITY, P.PRICE * S.UNITS AS SALES FROM PRICES AS P LEFT JOIN UNITSSOLD AS S ON P.PRODUCT_ID = S.PRODUCT_ID AND S.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE) SELECT T1.PRODUCT_ID AS PRODUCT_ID, ROUND(CAST(SUM(T1.SALES) AS REAL) / SUM(T1.QUANTITY), 2) AS AVERAGE_PRICE FROM T1 GROUP BY T1.PRODUCT_ID;

/*
Prediction Result:
(1, None)
*/