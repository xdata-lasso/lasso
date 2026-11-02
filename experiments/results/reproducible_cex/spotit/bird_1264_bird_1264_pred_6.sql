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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 14, 15, 0, 16, 0, 17, 18, 19, 20, 21, 1);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 44, 45, 0, 46, 0, 47, 48, 49, 50, 51, 1);
INSERT INTO PATIENT VALUES (0, 74, '0001-01-01', '0001-01-01', '0001-01-01', 75, 76);
INSERT INTO PATIENT VALUES (-1, 77, '0001-01-01', '0001-01-01', '0001-01-01', 78, 79);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 22, 23, 24, 0, 25, 26, 0, 0, 0, 0, 27, 28, 29, 30, 0, 31, 0, 32, 0, 0, 0, 33, 0, 0, 0, 34, 35, 36, 0, 11, 37, 38, 39, 40, 41, 42, 43, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 52, 53, 54, 0, 55, 56, 0, 0, 0, 0, 57, 58, 59, 60, 0, 61, 0, 62, 0, 0, 0, 63, 0, 0, 0, 64, 65, 66, 0, 11, 67, 68, 69, 70, 71, 72, 73, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.C4 > 10 AND T1.Diagnosis = 'APS';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Laboratory.ID) FROM Examination INNER JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Examination.Thrombosis = 1 AND Laboratory.C4 > 10;

/*
Prediction Result:
(1,)
*/