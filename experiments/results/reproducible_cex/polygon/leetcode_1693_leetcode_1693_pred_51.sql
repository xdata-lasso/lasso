-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-10', '11', NULL, 5);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, '10', 6, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, '10', 1, 1)
('1000-01-10', '11', 0, 1)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS FROM DAILYSALES GROUP BY MAKE_NAME, DATE_ID;

/*
Prediction Result:
(None, '10', 1, 1)
('1000-01-10', '11', 1, 0)
*/