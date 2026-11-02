-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dailysales (date_id, make_name, lead_id, partner_id) VALUES ('2023-01-01', 'default2', 0, NULL), ('2023-01-02', NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2023-01-01', 'default2', 1, 0)
('2023-01-02', None, 0, 1)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT (LEAD_ID)) AS UNIQUE_LEADS, COUNT(DISTINCT (PARTNER_ID)) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME ORDER BY DATE_ID DESC, MAKE_NAME NULLS LAST, UNIQUE_LEADS NULLS LAST, UNIQUE_PARTNERS NULLS LAST;

/*
Prediction Result:
('2023-01-02', None, 0, 1)
('2023-01-01', 'default2', 1, 0)
*/