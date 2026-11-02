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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 55, 56, 0, 57, 0, 58, 59, 60, 61, 62, 2);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 63, 64, 0, 65, 0, 66, 67, 68, 69, 70, 1);
INSERT INTO PATIENT VALUES (0, 72, '0001-01-01', '0001-01-01', '0001-01-01', 73, 74);
INSERT INTO PATIENT VALUES (1, 75, '0001-01-01', '0001-01-01', '0001-01-01', 76, 77);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 11, 12, 14, 0, 15, 16, 0, 0, 0, 0, 17, 18, 19, 20, 0, 13, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 24, 25, 0, 0, 26, 27, 28, 29, 30, 31, 32, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 33, 34, 35, 0, 36, 37, 0, 0, 0, 0, 38, 39, 40, 41, 0, 13, 0, 42, 0, 0, 0, 43, 0, 0, 0, 44, 45, 46, 0, 0, 47, 48, 49, 50, 51, 52, 53, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.PT < 14 AND T3.Thrombosis < 3 AND T3.Thrombosis > 0;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT p.ID) AS NumberOfPatients FROM Patient AS p JOIN Examination AS e ON p.ID = e.ID JOIN Laboratory AS l ON p.ID = l.ID WHERE e.Thrombosis IN (1, 2) AND l.PT < 14;

/*
Prediction Result:
(1,)
*/