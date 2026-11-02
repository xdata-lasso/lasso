-- Schema DDL
CREATE TABLE "EXAMINATION" (
    "ID" INT,
    "EXAMINATION_DATE" DATE,
    "ACL_IGG" FLOAT,
    "ACL_IGM" FLOAT,
    "ANA" INT,
    "ANA_PATTERN" TEXT,
    "ACL_IGA" INT,
    "DIAGNOSIS" TEXT,
    "KCT" TEXT,
    "RVVT" TEXT,
    "LAC" TEXT,
    "SYMPTOMS" TEXT,
    "THROMBOSIS" INT,
    FOREIGN KEY ("ID") REFERENCES "PATIENT"("ID")
);
CREATE TABLE "PATIENT" (
    "ID" INT,
    "SEX" TEXT,
    "BIRTHDAY" DATE,
    "DESCRIPTION" DATE,
    "FIRST_DATE" DATE,
    "ADMISSION" TEXT,
    "DIAGNOSIS" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "LABORATORY" (
    "ID" INT,
    "DATE" DATE,
    "GOT" INT,
    "GPT" INT,
    "LDH" INT,
    "ALP" INT,
    "TP" FLOAT,
    "ALB" FLOAT,
    "UA" FLOAT,
    "UN" INT,
    "CRE" FLOAT,
    "T_BIL" FLOAT,
    "T_CHO" INT,
    "TG" INT,
    "CPK" INT,
    "GLU" INT,
    "WBC" FLOAT,
    "RBC" FLOAT,
    "HGB" FLOAT,
    "HCT" FLOAT,
    "PLT" INT,
    "PT" FLOAT,
    "APTT" INT,
    "FG" FLOAT,
    "PIC" INT,
    "TAT" INT,
    "TAT2" INT,
    "U_PRO" TEXT,
    "IGG" INT,
    "IGA" INT,
    "IGM" INT,
    "CRP" TEXT,
    "RA" TEXT,
    "RF" TEXT,
    "C3" INT,
    "C4" INT,
    "RNP" TEXT,
    "SM" TEXT,
    "SC170" TEXT,
    "SSA" TEXT,
    "SSB" TEXT,
    "CENTROMEA" TEXT,
    "DNA" TEXT,
    "DNA_II" INT,
    PRIMARY KEY ("DATE", "ID"),
    FOREIGN KEY ("ID") REFERENCES "PATIENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 11, 12, 0, 13, 0, 14, 15, 16, 3516500448579243099, 17, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 18, 19, 0, 20, 0, 21, 22, 3516500448579243099, 23, 24, 0);
INSERT INTO PATIENT VALUES (1, 70, '0001-01-01', '0001-01-01', '0001-01-01', 71, 72);
INSERT INTO PATIENT VALUES (0, 73, '0001-01-01', '0001-01-01', '0001-01-01', 74, 75);
INSERT INTO LABORATORY VALUES (1, '0001-01-02', 0, 0, 0, 0, 26, 27, 28, 0, 29, 30, 0, 0, 249, 0, 31, 32, 33, 34, 0, 35, 0, 36, 0, 0, 0, 37, 0, 0, 0, 38, 39, 40, 0, 0, 41, 42, 43, 44, 45, 46, 47, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 48, 49, 50, 0, 51, 52, 0, 0, 249, 0, 53, 54, 55, 56, 0, 57, 0, 58, 0, 0, 0, 59, 0, 0, 0, 60, 61, 62, 0, 0, 63, 64, 65, 66, 67, 68, 69, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.CPK < 250 AND (T3.KCT = '+' OR T3.RVVT = '+' OR T3.LAC = '+');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.ID) FROM Examination AS e JOIN Laboratory AS l ON e.ID = l.ID WHERE l.CPK < 250 AND (e.KCT = '+' OR e.RVVT = '+' OR e.LAC = '+');

/*
Prediction Result:
(0,)
*/