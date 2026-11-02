-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-05-10', 'bmw', NULL, 1);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-05-10', 'bmw', 1, NULL);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-05-10', 'bmw', NULL, NULL);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-05-10', 'bmw', 2, 2);
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES ('2021-05-11', 'bmw', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('2021-05-10', 'bmw', 2, 2)
('2021-05-11', 'bmw', 0, 0)
*/

-- Prediction Query
SELECT A.DATE_ID, A.MAKE_NAME, COUNT(DISTINCT A.LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT A.PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES AS B LEFT JOIN DAILYSALES AS A ON A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME WHERE B.LEAD_ID <= A.LEAD_ID AND B.PARTNER_ID <= A.PARTNER_ID GROUP BY A.DATE_ID, A.MAKE_NAME;

/*
Prediction Result:
('2021-05-10', 'bmw', 1, 1)
*/