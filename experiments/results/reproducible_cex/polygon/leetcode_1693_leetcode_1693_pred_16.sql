-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-15', NULL, NULL, 10);
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-14', '15', NULL, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('1000-01-14', '15', 0, 1)
('1000-01-15', None, 0, 1)
*/

-- Prediction Query
SELECT A.DATE_ID, A.MAKE_NAME, A.UNIQUE_LEADS, B.UNIQUE_PARTNERS FROM (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS FROM DAILYSALES WHERE NOT DATE_ID IS NULL AND NOT MAKE_NAME IS NULL GROUP BY DATE_ID, MAKE_NAME) AS A LEFT JOIN (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES WHERE NOT DATE_ID IS NULL AND NOT MAKE_NAME IS NULL GROUP BY DATE_ID, MAKE_NAME) AS B ON A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME;

/*
Prediction Result:
('1000-01-14', '15', 0, 1)
*/