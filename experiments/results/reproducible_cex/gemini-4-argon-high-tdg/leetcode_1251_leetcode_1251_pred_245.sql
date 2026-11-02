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
WITH PRICE_PER_PERIOD AS (SELECT A.PRODUCT_ID, A.PURCHASE_DATE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN B.PRICE ELSE 0 END AS PRODUCT_PRICE, CASE WHEN A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE THEN A.UNITS ELSE 0 END AS UNITS FROM UNITSSOLD AS A LEFT JOIN PRICES AS B ON A.PRODUCT_ID = B.PRODUCT_ID AND A.PURCHASE_DATE BETWEEN B.START_DATE AND B.END_DATE), TOTAL_PRODUCT_PRICE AS (SELECT PRODUCT_ID, PURCHASE_DATE, UNITS, PRODUCT_PRICE * UNITS AS TOTAL_PRICE FROM PRICE_PER_PERIOD) SELECT PRODUCT_ID, ROUND(CAST(SUM(TOTAL_PRICE) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM TOTAL_PRODUCT_PRICE GROUP BY 1 ORDER BY 1, PRODUCT_ID NULLS LAST, AVERAGE_PRICE NULLS LAST;

/*
Prediction Result:
(2, None)
(3, None)
(4, 50.0)
*/