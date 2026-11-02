-- Schema DDL
CREATE TABLE "DailySales" ("date_id" DATE, "make_name" TEXT(255), "lead_id" INTEGER, "partner_id" INTEGER, CHECK ("lead_id" <> 'DailySales.partner_id'));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dailysales --
INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -55602865, -59984348);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -664303813, -1022641847);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -1726781632, 247012447);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -1980249628, -734455130);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', 1744686505, -1633151678);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -252690330, 1115440883);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, 1644814318, 1465859724);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -1349201381, 1019800248);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', NULL, -1910425938, -845863578);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -1610064545, 429706943);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', 462974032, -1137908826);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -918961358, -1602639011);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', -45536098, 1861536320);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', 44952191, 1151980946);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES ('2024-06-15', 'dai_5cbef0', 1620389964, 546571701);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_5cbef0', 947159877, 1990080517);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_5cbef0', 1408123494, -1964997180);

INSERT INTO "dailysales" ("date_id", "make_name", "lead_id", "partner_id") VALUES (NULL, 'dai_5cbef0', 1149850321, -1833165707);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_id, make_name, COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners FROM DailySales GROUP BY date_id, make_name;

/*
Gold Result:
(None, 'dai_5cbef0', 3, 3)
('2024-06-15', None, 3, 3)
('2024-06-15', 'dai_5cbef0', 12, 12)
*/

-- Prediction Query
SELECT A.DATE_ID, A.MAKE_NAME, COUNT(DISTINCT (A.LEAD_ID)) AS UNIQUE_LEADS, COUNT(DISTINCT (A.PARTNER_ID)) AS UNIQUE_PARTNERS FROM DAILYSALES AS A CROSS JOIN DAILYSALES AS B WHERE A.DATE_ID = B.DATE_ID AND A.MAKE_NAME = B.MAKE_NAME GROUP BY A.DATE_ID, A.MAKE_NAME;

/*
Prediction Result:
('2024-06-15', 'dai_5cbef0', 12, 12)
*/