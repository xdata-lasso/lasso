-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dailysales --
INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -55602865, -59984348);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -664303813, -1022641847);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -1726781632, 247012447);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -1980249628, -734455130);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', 1744686505, -1633151678);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -252690330, 1115440883);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', 1644814318, 1465859724);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -1349201381, 1019800248);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -1910425938, -845863578);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -1610064545, 429706943);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, 462974032, -1137908826);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -918961358, -1602639011);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', -45536098, 1861536320);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', 44952191, 1151980946);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_50ad03', 1620389964, 546571701);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_50ad03', 947159877, 1990080517);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_50ad03', 1408123494, -1964997180);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_50ad03', 1149850321, -1833165707);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'dai_50ad03', 3, 3)
('2024-06-15', None, 3, 3)
('2024-06-15', 'dai_50ad03', 12, 12)
*/

-- Prediction Query
SELECT DATE_ID, MAKE_NAME, (SELECT COUNT(*) FROM (SELECT LEAD_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY LEAD_ID) AS T) AS UNIQUE_LEADS, (SELECT COUNT(*) FROM (SELECT PARTNER_ID FROM DAILYSALES WHERE DATE_ID = D.DATE_ID AND MAKE_NAME = D.MAKE_NAME GROUP BY PARTNER_ID) AS T) AS UNIQUE_PARTNERS FROM DAILYSALES AS D GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
(None, 'dai_50ad03', 0, 0)
('2024-06-15', None, 0, 0)
('2024-06-15', 'dai_50ad03', 12, 12)
*/