-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', '2020-01-31', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-02-01', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH PRICE_PER_PERIOD AS (SELECT A.PRODUCT_ID, A.PURCHASE_DATE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN B.PRICE ELSE 0 END AS PRODUCT_PRICE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN A.UNITS ELSE 0 END AS UNITS FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE), TOTAL_PRODUCT_PRICE AS (SELECT PRODUCT_ID, PURCHASE_DATE, UNITS, PRODUCT_PRICE * UNITS AS TOTAL_PRICE FROM PRICE_PER_PERIOD) SELECT PRODUCT_ID, ROUND(CAST(SUM(TOTAL_PRICE) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM TOTAL_PRODUCT_PRICE GROUP BY 1 ORDER BY 1, PRODUCT_ID NULLS LAST, AVERAGE_PRICE NULLS LAST;

/*
Prediction Result:
(1, None)
*/