-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DailySales (date_id, make_name, lead_id, partner_id) VALUES (NULL, 'toyota', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'toyota', 1, 1)
*/

-- Prediction Query
SELECT A.DATE_ID, A.MAKE_NAME, COUNT(DISTINCT (A.LEAD_ID)) AS UNIQUE_LEADS, COUNT(DISTINCT (A.PARTNER_ID)) AS UNIQUE_PARTNERS FROM DAILYSALES AS A CROSS JOIN DAILYSALES AS B WHERE A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME GROUP BY A.DATE_ID, A.MAKE_NAME;

/*
Prediction Result:
*/