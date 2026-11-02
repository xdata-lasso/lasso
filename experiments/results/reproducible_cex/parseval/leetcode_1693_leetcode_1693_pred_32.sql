-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dailysales --
INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -55602865, -59984348);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -664303813, -1022641847);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -1726781632, 247012447);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -1980249628, -734455130);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', 1744686505, -1633151678);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -252690330, 1115440883);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, 1644814318, 1465859724);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -1349201381, 1019800248);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -1910425938, -845863578);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -1610064545, 429706943);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', 462974032, -1137908826);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', -918961358, -1602639011);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_fef9a4', -45536098, 1861536320);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_fef9a4', 44952191, 1151980946);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_fef9a4', 1620389964, 546571701);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', 947159877, 1990080517);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', 1408123494, -1964997180);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_fef9a4', 1149850321, -1833165707);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'dai_fef9a4', 3, 3)
('2024-06-15', None, 3, 3)
('2024-06-15', 'dai_fef9a4', 12, 12)
*/

-- Prediction Query
SELECT MAKE_NAME, DATE_ID, COUNT(DISTINCT LEAD_ID) AS UNIQUE_LEADS, COUNT(DISTINCT PARTNER_ID) AS UNIQUE_PARTNERS FROM DAILYSALES GROUP BY DATE_ID, MAKE_NAME;

/*
Prediction Result:
('dai_fef9a4', None, 3, 3)
(None, '2024-06-15', 3, 3)
('dai_fef9a4', '2024-06-15', 12, 12)
*/