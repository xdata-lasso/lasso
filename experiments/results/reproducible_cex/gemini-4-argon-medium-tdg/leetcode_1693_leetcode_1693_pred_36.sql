-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'toyota', 0, 1);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'toyota', 0, 1);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'toyota', 0, 2);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'toyota', 1, 2);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-07', 'toyota', 0, 2);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'honda', 1, 0);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'honda', 2, 0);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2020-12-08', 'honda', 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2020-12-07', 'toyota', 1, 1)
('2020-12-08', 'honda', 3, 1)
('2020-12-08', 'toyota', 2, 2)
*/

-- Prediction Query
SELECT COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS, DATE_ID, MAKE_NAME FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
(1, 1, '2020-12-07', 'toyota')
(3, 1, '2020-12-08', 'honda')
(2, 2, '2020-12-08', 'toyota')
*/