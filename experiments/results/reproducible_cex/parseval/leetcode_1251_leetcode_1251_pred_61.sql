-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: prices --
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '1970-01-01', '1991-02-19', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (-2147483647, '2024-12-12', '2024-03-30', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (2, '1921-02-20', '2028-02-24', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (3, '2022-08-20', '2022-07-21', 1861536320);

-- Inserting into table: unitssold --
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-04-14', 247012447);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-11', 809183447);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-07-04', 1914020640);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-01-03', 906324270);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-05-06', 2122220075);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-08-24', 13244799);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-08-07', 1019800248);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-10-03', 1526238907);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-04-29', 462974032);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-01-23', 1419861592);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-04-12', 374105386);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-02-24', 283598170);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-04-13', 781505063);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-03-14', 2107872094);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-08-27', 743312762);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-10-16', 2074205376);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-01-29', 2137741668);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-04-03', 90119032);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-03-14', 1775126557);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-03-04', 2123196517);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-08-25', 1485335077);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1927-10-24', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-11-10', 392822403);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-02', 244829661);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-01-18', 1661181156);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-04-09', 1649269347);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-15', 222415430);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-12-15', 537874887);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-03', 910894705);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-01-26', 1675430660);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-10-23', 233994589);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1927-10-24', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-09-16', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-05-18', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-05-25', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-12-18', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-06-20', 1575412235);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-08-31', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-07-15', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '2020-08-25', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-06-09', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-06', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-15', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-09-23', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-21', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-12-06', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-05-01', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-01-20', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-01', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 1.0)
(2, None)
*/

-- Prediction Query
WITH TOTAL_UNITS AS (SELECT U1.PRODUCT_ID, SUM(U1.UNITS) AS TOTAL_UNITS FROM UNITSSOLD AS U1 GROUP BY U1.PRODUCT_ID), TOTAL_DAILY_REVENUE AS (SELECT P.PRODUCT_ID, U2.PURCHASE_DATE, (P.PRICE * U2.UNITS) AS TOTAL_DAILY_REVENUE FROM PRICES AS P INNER JOIN UNITSSOLD AS U2 ON P.PRODUCT_ID = U2.PRODUCT_ID WHERE U2.PURCHASE_DATE BETWEEN P.START_DATE AND P.END_DATE), TOTAL_REVENUE AS (SELECT TOTAL_DAILY_REVENUE.PRODUCT_ID, SUM(TOTAL_DAILY_REVENUE.TOTAL_DAILY_REVENUE) AS TOTAL_REVENUE FROM TOTAL_DAILY_REVENUE GROUP BY TOTAL_DAILY_REVENUE.PRODUCT_ID) SELECT TOTAL_UNITS.PRODUCT_ID, ROUND((CAST(TOTAL_REVENUE.TOTAL_REVENUE AS REAL) / TOTAL_UNITS.TOTAL_UNITS), 2) AS AVERAGE_PRICE FROM TOTAL_UNITS JOIN TOTAL_REVENUE ON TOTAL_UNITS.PRODUCT_ID = TOTAL_REVENUE.PRODUCT_ID;

/*
Prediction Result:
(1, 0.0)
(2, None)
*/