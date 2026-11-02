-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('C1', 99.9);
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('C2', 50.0);
INSERT INTO satscores (cds, NumTstTakr) VALUES ('C2', 250);
INSERT INTO satscores (cds, NumTstTakr) VALUES ('C3', 350);
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
(250,)
*/