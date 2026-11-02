-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-15', 'audi', 5, NULL);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-15', 'audi', 5, 12);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-15', 'audi', NULL, 12);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-15', 'audi', NULL, 15);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-15', 'bmw', NULL, NULL);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-01-16', 'audi', 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2021-01-15', 'audi', 1, 2)
('2021-01-15', 'bmw', 0, 0)
('2021-01-16', 'audi', 1, 0)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, (SELECT COUNT(*) FROM (SELECT LEAD_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY LEAD_ID) AS T) AS UNIQUE_LEADS, (SELECT COUNT(*) FROM (SELECT PARTNER_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY PARTNER_ID) AS T) AS UNIQUE_PARTNERS FROM DAILYSALES AS D GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
('2021-01-15', 'audi', 2, 3)
('2021-01-15', 'bmw', 1, 1)
('2021-01-16', 'audi', 1, 1)
*/