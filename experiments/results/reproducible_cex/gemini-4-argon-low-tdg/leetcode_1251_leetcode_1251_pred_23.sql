-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests floating point division vs integer division, and ROUND(..., 2) precision
-- Also tests date filtering where purchase_date is outside the valid range (before start_date and after end_date)
-- Also tests cross-product date overlap (Product 2's sale falls in Product 1's date range, testing a.product_id = b.product_id)
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2023-03-05', '2023-03-15', 1);
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (2, '2023-04-01', '2023-04-10', 100);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-03-04', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-03-10', 3);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2023-03-16', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2023-03-10', 5);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (2, '2023-04-05', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 1.0)
(2, 100.0)
*/

-- Prediction Query
SELECT A.PRODUCT_ID, ROUND(CAST(SUM(A.UNITS * B.PRICE) AS REAL(7, 2)) / CAST(SUM(A.UNITS) AS REAL(7, 2)), 2) AS AVERAGE_PRICE FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE GROUP BY A.PRODUCT_ID;

/*
Prediction Result:
(1, 0.13)
(2, 37.5)
*/