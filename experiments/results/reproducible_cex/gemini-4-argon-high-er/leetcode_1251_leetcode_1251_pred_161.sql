-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', '2020-01-31', 800000000000001);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2020-01-01', '2020-01-31', 7000000000000002);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-01-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-01-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-01-05', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2020-01-05', 1);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2020-01-05', 1);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2020-01-05', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 800000000000001.1)
(2, 7000000000000003.0)
*/

-- Prediction Query
SELECT A.PRODUCT_ID, ROUND(CAST(SUM(REV_BY_DATE) AS REAL) / SUM(A.UNITS), 2) AS AVERAGE_PRICE FROM (SELECT P.PRODUCT_ID, US.PURCHASE_DATE, P.PRICE * US.UNITS AS REV_BY_DATE, US.UNITS FROM PRICES AS P JOIN UNITSSOLD AS US ON US.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE AND P.PRODUCT_ID = US.PRODUCT_ID GROUP BY P.PRODUCT_ID, US.PURCHASE_DATE) AS A GROUP BY A.PRODUCT_ID;

/*
Prediction Result:
(1, 800000000000001.0)
(2, 7000000000000002.0)
*/