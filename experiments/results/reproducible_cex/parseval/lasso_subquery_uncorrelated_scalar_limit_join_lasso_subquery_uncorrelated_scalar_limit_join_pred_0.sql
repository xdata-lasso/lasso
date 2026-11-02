-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: satscores --
INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('t1__639734', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('t1__d12267', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('c', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('i', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('@', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('=', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('T', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('B', 1);

INSERT INTO "satscores" ("cds", "numtsttakr") VALUES ('A', 1);

-- Inserting into table: frpm --
INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('t1__639734', 582.588439);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('cdscode_2', 680.190136);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('@', 0.5);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('l', 0.5);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('#', 0.5);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('"', 0.5);

INSERT INTO "frpm" ("cdscode", "frpm_count") VALUES ('t2__0a9ac1', 487.053947);
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
(1,)
*/