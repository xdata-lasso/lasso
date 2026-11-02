-- Schema DDL
CREATE TABLE satscores (cds TEXT PRIMARY KEY, NumTstTakr INTEGER);

CREATE TABLE frpm (CDSCode TEXT PRIMARY KEY, FRPM_Count REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO frpm (cdscode, frpm_count) VALUES ('default1', 1.0), ('default2', NULL), ('unique_2', 0.0), ('unique_3', 0.0), ('unique_4', NULL), ('unique_5', 0.0), ('unique_6', 2.0), ('unique_7', NULL), ('unique_8', 1.0), ('unique_9', NULL);
INSERT INTO satscores (cds, numtsttakr) VALUES ('default2', 2);
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
(2,)
*/