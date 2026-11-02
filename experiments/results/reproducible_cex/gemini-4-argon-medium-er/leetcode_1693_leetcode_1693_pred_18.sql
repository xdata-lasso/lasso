-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-01-01', 'Toyota', NULL, 1);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES (NULL, 'Toyota', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'Toyota', 1, 1)
('2020-01-01', 'Toyota', 0, 1)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, (SELECT COUNT(*) FROM (SELECT LEAD_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY LEAD_ID) AS T) AS UNIQUE_LEADS, (SELECT COUNT(*) FROM (SELECT PARTNER_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY PARTNER_ID) AS T) AS UNIQUE_PARTNERS FROM DAILYSALES AS D GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
(None, 'Toyota', 0, 0)
('2020-01-01', 'Toyota', 1, 1)
*/