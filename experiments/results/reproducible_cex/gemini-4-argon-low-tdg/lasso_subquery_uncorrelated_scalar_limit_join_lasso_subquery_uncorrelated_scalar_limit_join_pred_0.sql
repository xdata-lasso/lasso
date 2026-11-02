-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('TOP_MISSING', 999.0);
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('SECOND_PRESENT', 888.0);
INSERT INTO satscores (cds, NumTstTakr) VALUES ('SECOND_PRESENT', 75);
INSERT INTO satscores (cds, NumTstTakr) VALUES ('OTHER', 25);
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
(75,)
*/