-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (76, '1002-05-02', '1002-05-04', 2);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (NULL, '1002-05-03', 1);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (NULL, NULL, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT P.PRODUCT_ID, P.START_DATE, P.END_DATE, U.UNITS AS QUANTITY, (P.PRICE * U.UNITS) AS SELLING_PRICE FROM PRICES AS P LEFT JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE) SELECT PRODUCT_ID, ROUND((CAST(SUM(SELLING_PRICE) * 1.00 AS REAL) / SUM(QUANTITY)), 2) AS AVERAGE_PRICE FROM CTE GROUP BY PRODUCT_ID;

/*
Prediction Result:
(76, None)
*/