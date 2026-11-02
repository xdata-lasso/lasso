-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Prices (product_id, start_date, end_date, price) VALUES (1, '2020-01-01', '2020-01-10', 10);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-01-05', 5);
INSERT INTO UnitsSold (product_id, purchase_date, units) VALUES (1, '2020-02-01', 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 10.0)
*/

-- Prediction Query
SELECT PRODUCT_ID, ROUND(CAST(SUM(INCOME) AS REAL) / SUM(UNITS), 2) AS AVERAGE_PRICE FROM UNITSSOLD JOIN (SELECT U.PRODUCT_ID, PRICE * UNITS AS INCOME FROM UNITSSOLD AS U JOIN PRICES AS P ON U.PRODUCT_ID = P.PRODUCT_ID AND U.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE) AS G USING (PRODUCT_ID) GROUP BY PRODUCT_ID;

/*
Prediction Result:
(1, 5.0)
*/