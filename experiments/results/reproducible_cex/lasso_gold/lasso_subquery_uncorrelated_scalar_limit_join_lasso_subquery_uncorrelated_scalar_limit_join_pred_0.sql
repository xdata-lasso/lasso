-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('all', 1035.5);
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('better', 1040.5);
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('discover', 1045.5);
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('early', 1050.5);
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('mouth', 1150.5);
INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('all', 1039);
INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('better', 1044.0);
INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('discover', 1049.0);
INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('early', 1054.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NumTstTakr FROM satscores WHERE cds = (SELECT CDSCode FROM frpm ORDER BY FRPM_Count DESC, frpm.cdscode NULLS LAST LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.NumTstTakr FROM satscores AS T1 INNER JOIN frpm AS T2 ON T1.cds = T2.CDSCode ORDER BY T2.FRPM_Count DESC, T1.cds NULLS LAST, T2.cdscode NULLS LAST LIMIT 1;

/*
Prediction Result:
(1054,)
*/