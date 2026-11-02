-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2019-02-01', '2019-02-28', 5);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2019-02-01', '2019-02-28', 13);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-02-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-02-20', 15);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2019-03-01', 20);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-01-31', 8);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-02-10', 3);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2019-02-15', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 5.0)
(2, 13.0)
*/

-- Prediction Query
WITH TOTAL_DOLLAR_STEP1 AS (SELECT U.PRODUCT_ID, P.PRICE * U.UNITS AS TOTAL_LINES FROM UNITSSOLD AS U LEFT JOIN PRICES AS P ON U.PRODUCT_ID = P.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE), TOTAL_DOLLAR_STEP2 AS (SELECT PRODUCT_ID, SUM(TOTAL_LINES) AS TOTAL_PRICE FROM TOTAL_DOLLAR_STEP1 GROUP BY PRODUCT_ID), UNITS_TOTAL AS (SELECT PRODUCT_ID, SUM(UNITS) AS TOTAL_U FROM UNITSSOLD GROUP BY PRODUCT_ID) SELECT A.PRODUCT_ID, ROUND(CAST(A.TOTAL_PRICE AS REAL) / B.TOTAL_U, 2) AS AVERAGE_PRICE FROM TOTAL_DOLLAR_STEP2 AS A INNER JOIN UNITS_TOTAL AS B ON A.PRODUCT_ID = B.PRODUCT_ID;

/*
Prediction Result:
(1, 2.78)
(2, 6.07)
*/