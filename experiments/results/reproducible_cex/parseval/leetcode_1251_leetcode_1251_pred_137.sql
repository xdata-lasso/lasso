-- Schema DDL
CREATE TABLE "Prices" ("product_id" INTEGER UNIQUE, "start_date" DATE, "end_date" DATE, "price" INTEGER, PRIMARY KEY ("product_id", "start_date", "end_date"), CHECK ("start_date" <= 'Prices.end_date'), CHECK ("price" > 0));

CREATE TABLE "UnitsSold" ("product_id" INTEGER, "purchase_date" DATE, "units" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Prices" ("product_id"), CHECK ("units" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: prices --
INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (1, '2024-06-15', '2024-06-15', 247012447);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (-2147483647, '2024-06-15', '2024-06-15', 1465859724);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (2, '2024-06-15', '2024-06-15', 2087640001);

INSERT INTO "prices" ("product_id", "start_date", "end_date", "price") VALUES (5, '2023-05-08', '2025-07-01', 1149850321);

-- Inserting into table: unitssold --
INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-02-11', 809183447);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-07-04', 1914020640);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-12-12', 1219478689);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-08-23', 1644814318);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-04-22', 700293388);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-11-30', 1908028688);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-03-30', 1072996612);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-01-16', 429706943);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-09-14', 1236688122);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-06-13', 44952191);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-12-14', 1620389964);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-09-12', 947159877);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2020-07-02', 528680845);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2025-03-28', 1155439218);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2025-06-20', 742285925);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2020-03-30', 757448742);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2022-07-11', 902887186);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-10-25', 418417917);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-06-23', 775304493);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2025-06-25', 1884179925);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2022-08-27', 882961052);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2024-10-14', 274769912);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-05-17', 1898504886);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-08-06', 1644911394);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2022-07-25', 226938182);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2022-02-06', 1178636309);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2021-08-16', 105869088);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-12-17', 481163439);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2023-07-07', 1909986641);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2023-09-01', 176380444);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2020-04-20', 1692174491);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (2, '2025-07-21', 1255852738);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (5, '2024-02-23', 1178000634);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-12-28', 176555546);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-11-04', 1196308825);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-09-07', 1581736075);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-12-03', 1298861365);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-02-11', 722884590);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-08-25', 401805964);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-02-11', 806170397);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-03-20', 1382410067);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-05-01', 172461907);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-07-01', 1443629118);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-12-23', 982314585);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-02-18', 1038566008);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-10-25', 37673509);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-11-20', 602161869);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-11-23', 2094425101);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-02-10', 1294666887);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-06-23', 61479715);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-06-18', 2011234363);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-08-02', 1360271423);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-05-09', 1129658414);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-06-17', 600440952);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-09-06', 1972233925);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-11-12', 804529642);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-02-15', 1235416111);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-10-12', 518609210);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-11-02', 195720193);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-10-28', 1732258051);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-10-14', 1523825314);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-07-08', 1371234901);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-12-23', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-11-06', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-06-30', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-07-09', 1992637800);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2023-06-19', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-07-27', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-06-04', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-08-28', 1870300798);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2025-07-11', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-10-24', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-12-09', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-08-09', 569007824);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2022-08-18', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2020-10-02', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2024-11-08', NULL);

INSERT INTO "unitssold" ("product_id", "purchase_date", "units") VALUES (1, '2021-07-27', 1897687032);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.product_id, ROUND((CAST(SUM((units * price)) AS REAL) / SUM(units)), 2) AS average_price FROM prices AS a JOIN unitssold AS b ON (a.product_id = b.product_id AND b.purchase_date BETWEEN a.start_date AND a.end_date) GROUP BY a.product_id;

/*
Gold Result:
(5, 1149850321.0)
*/

-- Prediction Query
WITH T1 AS (SELECT P.PRODUCT_ID, SUM(UNITS * PRICE) AS TOTAL_PRICE FROM UNITSSOLD AS U JOIN PRICES AS P ON PURCHASE_DATE BETWEEN START_DATE AND END_DATE AND U.PRODUCT_ID = P.PRODUCT_ID GROUP BY P.PRODUCT_ID), T2 AS (SELECT PRODUCT_ID, SUM(UNITS) AS TOTAL_UNITS FROM UNITSSOLD GROUP BY PRODUCT_ID) SELECT T1.PRODUCT_ID, ROUND(CAST(TOTAL_PRICE AS REAL) / TOTAL_UNITS, 2) AS AVERAGE_PRICE FROM T1 JOIN T2 USING (PRODUCT_ID);

/*
Prediction Result:
(5, 630740178.14)
*/