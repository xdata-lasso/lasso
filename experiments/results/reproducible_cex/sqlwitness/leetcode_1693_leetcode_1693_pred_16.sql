-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO dailysales (date_id, make_name, lead_id, partner_id) VALUES (NULL, 'default1', 1, NULL), ('2023-01-01', NULL, 1, NULL), (NULL, NULL, 1, NULL), ('2023-01-01', 'default1', NULL, NULL), ('2023-01-02', 'default2', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, None, 1, 0)
(None, 'default1', 1, 0)
('2023-01-01', None, 1, 0)
('2023-01-01', 'default1', 0, 0)
('2023-01-02', 'default2', 0, 1)
*/

-- Prediction Query
SELECT A.DATE_ID, A.MAKE_NAME, A.UNIQUE_LEADS, B.UNIQUE_PARTNERS FROM (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS FROM DAILYSALES WHERE NOT DATE_ID IS NULL AND NOT MAKE_NAME IS NULL GROUP BY DATE_ID, MAKE_NAME) AS A LEFT JOIN (SELECT DATE_ID, MAKE_NAME, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES WHERE NOT DATE_ID IS NULL AND NOT MAKE_NAME IS NULL GROUP BY DATE_ID, MAKE_NAME) AS B ON A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME;

/*
Prediction Result:
('2023-01-01', 'default1', 0, 0)
('2023-01-02', 'default2', 0, 1)
*/