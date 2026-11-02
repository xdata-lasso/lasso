-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (NULL, '1991-11-22', 1057);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.PRODUCT_ID, ROUND(CAST(T2.REVENUE AS REAL) / T2.AMT, 2) AS AVERAGE_PRICE FROM (SELECT A.PRODUCT_ID, SUM(A.UNITS * B.PRICE) AS REVENUE, SUM(A.UNITS) AS AMT FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON (A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE >= B.START_DATE AND A.PURCHASE_DATE <= B.END_DATE) GROUP BY A.PRODUCT_ID) AS T2;

/*
Prediction Result:
(None, None)
*/