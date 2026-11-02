-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: prices --
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2024-06-15', '2028-02-24', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (-2147483647, '2024-06-15', '2024-06-15', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (2, '2024-06-15', '1991-02-19', 1);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (3, '2023-11-17', '2025-09-21', 1038707349);

-- Inserting into table: unitssold --
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-04-14', 247012447);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-11', 809183447);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-07-04', 1914020640);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-12-12', 1219478689);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-08-23', 1644814318);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-01-16', 429706943);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-09-14', 1236688122);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-02-26', 907682809);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-09-04', 1861536320);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-07-24', 546571701);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-09-18', 1990080517);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-02-24', 283598170);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-04-13', 781505063);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2020-03-14', 2107872094);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-08-27', 743312762);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-10-16', 2074205376);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-01-29', 2137741668);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-04-03', 90119032);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-03-14', 1775126557);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2020-03-04', 2123196517);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2020-08-25', 1485335077);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (3, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-11-10', 392822403);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-02', 244829661);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-01-18', 1661181156);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-04-09', 1649269347);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-15', 222415430);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-12-15', 537874887);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1927-10-24', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-03', 910894705);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-01-26', 1675430660);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-10-23', 233994589);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-06-20', 1575412235);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-07-24', 331812443);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-06-01', 1631231566);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-06-25', 1606439408);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-04-08', 638024588);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-10-25', 37673509);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1985-11-16', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-09-12', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-01-15', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-12-20', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-08-20', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2025-11-20', 602161869);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-11-23', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-03-11', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-02-10', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-03', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-02-05', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-04-05', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '1970-01-01', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(1, 1.0)
*/

-- Prediction Query
SELECT T1.PRODUCT_ID, ROUND(CAST(SUM(T1.TTL_SALES) AS REAL) / T2.TTL_UNITS, 2) AS AVERAGE_PRICE FROM (SELECT P1.PRODUCT_ID, (P1.PRICE * U1.UNITS) AS TTL_SALES FROM PRICES AS P1 JOIN UNITSSOLD AS U1 ON P1.PRODUCT_ID = U1.PRODUCT_ID WHERE U1.PURCHASE_DATE BETWEEN P1.START_DATE AND P1.END_DATE) AS T1 JOIN (SELECT PRODUCT_ID, SUM(UNITS) AS TTL_UNITS FROM UNITSSOLD GROUP BY PRODUCT_ID) AS T2 ON T1.PRODUCT_ID = T2.PRODUCT_ID GROUP BY T1.PRODUCT_ID;

/*
Prediction Result:
(1, 0.28)
*/