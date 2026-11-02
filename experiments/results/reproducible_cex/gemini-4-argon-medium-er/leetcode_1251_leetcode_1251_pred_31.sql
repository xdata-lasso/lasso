-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2023-01-01', '2023-01-10', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-02-01', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID AS PRODUCT_ID, ROUND(CAST(SUM(UNITS * PRICE) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM UNITSSOLD AS US LEFT JOIN PRICES AS P ON US.PRODUCT_ID = P.PRODUCT_ID AND P.START_DATE <= US.PURCHASE_DATE AND P.END_DATE >= US.PURCHASE_DATE GROUP BY P.PRODUCT_ID ORDER BY P.PRODUCT_ID, PRODUCT_ID NULLS LAST, AVERAGE_PRICE NULLS LAST;

/*
Prediction Result:
(None, None)
*/