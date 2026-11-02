-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dailysales (date_id, make_name, lead_id, partner_id) VALUES ('2023-01-02', NULL, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2023-01-02', None, 1, 0)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, (SELECT COUNT(DISTINCT (LEAD_ID)) FROM DAILYSALES AS D WHERE DAILYSALES.DATE_ID = D.DATE_ID AND DAILYSALES.MAKE_NAME = D.MAKE_NAME) AS UNIQUE_LEADS, (SELECT COUNT(DISTINCT (PARTNER_ID)) FROM DAILYSALES AS D1 WHERE DAILYSALES.DATE_ID = D1.DATE_ID AND DAILYSALES.MAKE_NAME = D1.MAKE_NAME) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
('2023-01-02', None, 0, 0)
*/