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
SELECT P1.PRODUCT_ID, ROUND(CAST(SUM(P1.PRICE * S1.UNITS) AS REAL) / (SUM(S1.UNITS)), 2) AS AVERAGE_PRICE FROM PRICES AS P1 LEFT JOIN UNITSSOLD AS S1 ON P1.PRODUCT_ID = S1.PRODUCT_ID AND S1.PURCHASE_DATE BETWEEN P1.START_DATE AND P1.END_DATE GROUP BY P1.PRODUCT_ID;

/*
Prediction Result:
(1, None)
(2, None)
(3, None)
(4, 50.0)
*/