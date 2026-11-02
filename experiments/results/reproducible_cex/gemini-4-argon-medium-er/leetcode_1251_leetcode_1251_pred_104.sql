-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2023-01-01', '2023-01-10', 10);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (1, '2023-01-05', 5);
INSERT INTO "UnitsSold" ("product_id", "purchase_date", "units") VALUES (1, '2023-02-01', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
SELECT T2.PRODUCT_ID, ROUND((CAST(T1.MUL AS REAL) / T2.SUM), 2) AS AVERAGE_PRICE FROM (SELECT P.PRODUCT_ID, SUM((P.PRICE * UNITS)) AS MUL FROM PRICES AS P LEFT JOIN UNITSSOLD AS U ON (P.PRODUCT_ID = U.PRODUCT_ID) WHERE START_DATE <= PURCHASE_DATE AND END_DATE >= PURCHASE_DATE GROUP BY P.PRODUCT_ID) AS T1 LEFT JOIN (SELECT PRODUCT_ID, SUM(UNITS) AS SUM FROM UNITSSOLD GROUP BY PRODUCT_ID) AS T2 ON (T1.PRODUCT_ID = T2.PRODUCT_ID);

/*
Prediction Result:
(1, 5.0)
*/