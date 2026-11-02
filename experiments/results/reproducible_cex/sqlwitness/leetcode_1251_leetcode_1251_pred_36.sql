-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO unitssold (product_id, purchase_date, units) VALUES (0, '2023-01-02', 2), (NULL, '2023-01-02', 1);
INSERT INTO prices (product_id, start_date, end_date, price) VALUES (1, '2023-01-01', '2023-01-02', 2), (0, '2023-01-01', '2023-01-01', 1), (3, '2023-01-02', '2023-01-02', 2), (2, '2023-01-02', '2023-01-02', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PRODUCT_ID, ROUND((CAST(SUM(P.PRICE * US.UNITS) AS REAL) / SUM(US.UNITS)), 2) AS AVERAGE_PRICE FROM PRICES AS P LEFT JOIN UNITSSOLD AS US ON P.PRODUCT_ID = US.PRODUCT_ID AND US.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE GROUP BY P.PRODUCT_ID;

/*
Prediction Result:
(0, None)
(1, None)
(2, None)
(3, None)
*/