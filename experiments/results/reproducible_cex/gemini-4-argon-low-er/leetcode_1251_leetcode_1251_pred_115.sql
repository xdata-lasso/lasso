-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', '2020-01-10', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-02-01', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT PRODUCT_ID, SUM(UNITS) AS SUMM FROM UNITSSOLD AS U GROUP BY 1) SELECT Z.PRODUCT_ID, ROUND(CAST(AVERAGE_PRICE AS REAL) / C.SUMM, 2) AS AVERAGE_PRICE FROM (SELECT P.PRODUCT_ID, SUM(CASE WHEN PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN PRICE * UNITS END) AS AVERAGE_PRICE FROM PRICES AS P CROSS JOIN UNITSSOLD AS U WHERE U.PRODUCT_ID = P.PRODUCT_ID GROUP BY 1) AS Z CROSS JOIN CTE AS C WHERE C.PRODUCT_ID = Z.PRODUCT_ID;

/*
Prediction Result:
(1, None)
*/