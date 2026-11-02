-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2021-05-01', '2021-05-31', 10);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2021-05-01', '2021-05-31', 20);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (3, '2021-05-01', '2021-05-31', 30);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (4, '2021-05-01', '2021-05-31', 50);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2021-04-30', 5);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (3, '2021-06-01', 6);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (4, '2021-05-15', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(4, 50.0)
*/

-- Prediction Query
SELECT PRODUCT_ID, COALESCE(ROUND(CAST(SUM(TOTAL_PRICE) AS REAL) / SUM(UNITS), 2), 0) AS AVERAGE_PRICE FROM (SELECT P.PRODUCT_ID AS PRODUCT_ID, UNITS, PRICE * UNITS AS TOTAL_PRICE FROM PRICES AS P LEFT JOIN UNITSSOLD AS US ON P.PRODUCT_ID = US.PRODUCT_ID AND PURCHASE_DATE BETWEEN START_DATE AND END_DATE) AS DATES GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1, 0)
(2, 0)
(3, 0)
(4, 50.0)
*/