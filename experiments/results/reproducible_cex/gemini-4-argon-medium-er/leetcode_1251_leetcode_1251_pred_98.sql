-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', '2020-01-31', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-02-15', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT PRODUCT_ID, ROUND(CAST(SUM(UNITS * (SELECT PRICE FROM PRICES WHERE PRODUCT_ID = A.PRODUCT_ID AND START_DATE <= A.PURCHASE_DATE AND END_DATE >= A.PURCHASE_DATE)) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM UNITSSOLD AS A GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1, None)
*/