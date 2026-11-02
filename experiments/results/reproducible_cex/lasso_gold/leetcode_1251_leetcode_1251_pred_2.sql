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
SELECT B.PRODUCT_ID, ROUND(CAST(SUM(B.UNITS * A.PRICE) AS REAL) / SUM(B.UNITS), 2) AS AVERAGE_PRICE FROM UNITSSOLD AS B LEFT JOIN PRICES AS A ON A.PRODUCT_ID = B.PRODUCT_ID AND A.START_DATE <= B.PURCHASE_DATE AND B.PURCHASE_DATE <= A.END_DATE GROUP BY 1;

/*
Prediction Result:
(None, None)
*/