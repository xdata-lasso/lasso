-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dailysales (date_id, make_name, lead_id, partner_id) VALUES ('2023-01-02', 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2023-01-02', 'default1', 0, 0)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS, DATE_ID, MAKE_NAME FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
(0, 0, '2023-01-02', 'default1')
*/