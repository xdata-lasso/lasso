-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-10', '11', NULL, NULL);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-09', '10', 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('1000-01-09', '10', 1, 0)
('1000-01-10', '11', 0, 0)
*/

-- Prediction Query
SELECT MAKE_NAME, DATE_ID, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
('10', '1000-01-09', 1, 0)
('11', '1000-01-10', 0, 0)
*/