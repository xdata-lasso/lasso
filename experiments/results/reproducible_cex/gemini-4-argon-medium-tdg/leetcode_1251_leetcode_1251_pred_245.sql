-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (101, '2022-01-01', '2022-12-31', 9);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (102, '2022-01-01', '2022-12-31', 25);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (101, '2023-01-01', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (102, '2022-06-01', 3);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (102, '2022-06-01', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(102, 25.0)
*/

-- Prediction Query
WITH PRICE_PER_PERIOD AS (SELECT A.PRODUCT_ID, A.PURCHASE_DATE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN B.PRICE ELSE 0 END AS PRODUCT_PRICE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN A.UNITS ELSE 0 END AS UNITS FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE), TOTAL_PRODUCT_PRICE AS (SELECT PRODUCT_ID, PURCHASE_DATE, UNITS, PRODUCT_PRICE * UNITS AS TOTAL_PRICE FROM PRICE_PER_PERIOD) SELECT PRODUCT_ID, ROUND(CAST(SUM(TOTAL_PRICE) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM TOTAL_PRODUCT_PRICE GROUP BY 1 ORDER BY 1, PRODUCT_ID NULLS LAST, AVERAGE_PRICE NULLS LAST;

/*
Prediction Result:
(101, None)
(102, 25.0)
*/