-- Schema DDL
CREATE TABLE "SATSCORES" (
    "CDS" TEXT,
    "NUMTSTTAKR" INT,
    PRIMARY KEY ("CDS")
);
CREATE TABLE "FRPM" (
    "CDSCODE" TEXT,
    "FRPM_COUNT" FLOAT,
    PRIMARY KEY ("CDSCODE")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SATSCORES VALUES (-1, 0);
INSERT INTO SATSCORES VALUES (2, -1);
INSERT INTO FRPM VALUES (-2, -2);
INSERT INTO FRPM VALUES (-1, -3);
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
(0,)
*/