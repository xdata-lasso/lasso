-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1107, '1976-03-13', '1976-03-14', 1108);
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1110, '1976-03-1', '31976-03-14', 1108);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1107, '1976-03-13', 1109);
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1107, '1976-03-13', 1109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1107, 1108.0)
*/

-- Prediction Query
WITH RECURSIVE CTE(PURCHASE_DATE) AS (SELECT MIN(START_DATE) FROM PRICES UNION ALL SELECT DATE(PURCHASE_DATE, '1 DAY') FROM CTE WHERE PURCHASE_DATE <= (SELECT MAX(END_DATE) FROM PRICES)) SELECT P.PRODUCT_ID, ROUND(CAST(SUM(P.PRICE * U.UNITS) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM PRICES AS P LEFT JOIN CTE AS D ON (D.PURCHASE_DATE >= P.START_DATE) AND (D.PURCHASE_DATE <= P.END_DATE) INNER JOIN UNITSSOLD AS U ON ((U.PRODUCT_ID = P.PRODUCT_ID) AND (D.PURCHASE_DATE = U.PURCHASE_DATE)) GROUP BY P.PRODUCT_ID;

/*
Prediction Result:
*/