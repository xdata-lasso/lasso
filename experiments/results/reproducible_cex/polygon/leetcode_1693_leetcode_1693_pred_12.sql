-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "DailySales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('1000-01-09', NULL, 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
('1000-01-09', None, 1, 0)
*/

-- Prediction Query
WITH CTE_LEAD AS (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME), CTE_PARTNER AS (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME) SELECT A.DATE_ID, A.MAKE_NAME, A.UNIQUE_LEADS, B.UNIQUE_PARTNERS FROM CTE_LEAD AS A INNER JOIN CTE_PARTNER AS B ON A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME;

/*
Prediction Result:
*/