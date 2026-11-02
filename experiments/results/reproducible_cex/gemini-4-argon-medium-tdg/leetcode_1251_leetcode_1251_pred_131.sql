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
WITH CTE AS (SELECT P.PRODUCT_ID, CASE WHEN U.PURCHASE_DATE BETWEEN START_DATE AND END_DATE THEN UNITS ELSE 0 END AS UNITS_SOLD, PRICE FROM PRICES AS P INNER JOIN UNITSSOLD AS U ON P.PRODUCT_ID = U.PRODUCT_ID) SELECT PRODUCT_ID, ROUND((CAST(SUM(PRICE * UNITS_SOLD) AS REAL) / SUM(UNITS_SOLD)), 2) AS AVERAGE_PRICE FROM CTE GROUP BY PRODUCT_ID;

/*
Prediction Result:
(101, None)
(102, 25.0)
*/