-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2020-01-01', NULL, 1, 2);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2020-01-02', NULL, 3, 4);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2020-01-01', '1', 5, 6);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2020-01-0', '11', 7, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2020-01-0', '11', 1, 1)
('2020-01-01', None, 1, 1)
('2020-01-01', '1', 1, 1)
('2020-01-02', None, 1, 1)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID || MAKE_NAME;

/*
Prediction Result:
('2020-01-01', None, 2, 2)
('2020-01-01', '1', 2, 2)
*/