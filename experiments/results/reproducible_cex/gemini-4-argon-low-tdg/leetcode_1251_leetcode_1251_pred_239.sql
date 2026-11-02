-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (purchase_date == start_date and purchase_date == end_date)
-- Also tests INNER JOIN vs LEFT JOIN (product 2 has no sales)
-- Also tests GROUP BY necessity (multiple products)
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2023-01-01', '2023-01-10', 10);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2023-01-01', '2023-01-10', 20);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (3, '2023-02-01', '2023-02-15', 15);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-01-01', 5);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-01-10', 15);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (3, '2023-02-05', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 10.0)
(3, 15.0)
*/

-- Prediction Query
SELECT T.PRODUCT_ID, ROUND(CAST((SUM(T.PRICE * U.UNITS)) AS REAL) / SUM(U.UNITS), 2) AS AVERAGE_PRICE FROM PRICES AS T LEFT JOIN UNITSSOLD AS U ON T.PRODUCT_ID = U.PRODUCT_ID AND T.START_DATE <= U.PURCHASE_DATE AND T.END_DATE >= U.PURCHASE_DATE GROUP BY T.PRODUCT_ID;

/*
Prediction Result:
(1, 10.0)
(2, None)
(3, 15.0)
*/