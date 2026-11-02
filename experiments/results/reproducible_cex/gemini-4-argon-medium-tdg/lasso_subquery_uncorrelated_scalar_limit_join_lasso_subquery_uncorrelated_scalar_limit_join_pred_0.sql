-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests when the top FRPM_Count row in frpm has NO matching row in satscores.
-- Distinguishes subquery LIMIT 1 from INNER JOIN ... ORDER BY ... LIMIT 1.
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('CDS_TOP_MISSING', 1000.0);
INSERT INTO frpm (CDSCode, FRPM_Count) VALUES ('CDS_SECOND_PRESENT', 900.0);
INSERT INTO satscores (cds, NumTstTakr) VALUES ('CDS_SECOND_PRESENT', 450);
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
(450,)
*/