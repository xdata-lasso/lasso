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
SELECT T2.PRODUCT_ID, ROUND(CAST(T2.REVENUE AS REAL) / T2.AMT, 2) AS AVERAGE_PRICE FROM (SELECT A.PRODUCT_ID, SUM(A.UNITS * B.PRICE) AS REVENUE, SUM(A.UNITS) AS AMT FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON (A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE >= B.START_DATE AND A.PURCHASE_DATE <= B.END_DATE) GROUP BY A.PRODUCT_ID) AS T2;

/*
Prediction Result:
(1, 2.78)
(2, 6.07)
*/