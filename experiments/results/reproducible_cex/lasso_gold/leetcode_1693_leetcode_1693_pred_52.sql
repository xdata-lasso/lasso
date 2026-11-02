-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'Lisa Jackson', 1041, 1042);
INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'Carla Gray', 1043, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'Carla Gray', 1, 1)
(None, 'Lisa Jackson', 1, 1)
*/

-- Prediction Query
SELECT D1.DATE_ID, D1.MAKE_NAME, (SELECT COUNT(DISTINCT D2.LEAD_ID) FROM DAILYSALES AS D2 WHERE D2.DATE_ID = D1.DATE_ID AND D2.MAKE_NAME = D1.MAKE_NAME) AS UNIQUE_LEADS, (SELECT COUNT(DISTINCT D2.PARTNER_ID) FROM DAILYSALES AS D2 WHERE D2.DATE_ID = D1.DATE_ID AND D2.MAKE_NAME = D1.MAKE_NAME) AS UNIQUE_PARTNERS FROM DAILYSALES AS D1 GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
(None, 'Carla Gray', 0, 0)
(None, 'Lisa Jackson', 0, 0)
*/