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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 14, 15, 0, 16, 0, 17, 18, 19, 20, 21, 0);
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 22, 23, 0, 24, 0, 25, 26, 27, 28, 29, 0);
INSERT INTO PATIENT VALUES (0, 75, '0001-01-01', '0001-01-01', '0001-01-01', 76, 77);
INSERT INTO PATIENT VALUES (-1, 78, '0001-01-01', '0001-01-01', '0001-01-01', 79, 80);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 31, 32, 33, 0, 34, 35, 0, 0, 0, 0, 36, 37, 38, 39, 0, 40, 0, 41, 0, 0, 0, 42, 900, 0, 0, 43, 44, 45, 0, 0, 46, 47, 48, 49, 50, 51, 52, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 53, 54, 55, 0, 56, 57, 0, 0, 0, 0, 58, 59, 60, 61, 0, 62, 0, 63, 0, 0, 0, 64, 1999, 0, 0, 65, 66, 67, 0, 0, 68, 69, 70, 71, 72, 73, 74, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T3.ID = T2.ID WHERE T2.IGG BETWEEN 900 AND 2000 AND NOT T3.Symptoms IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination INNER JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Laboratory.IGG > 900 AND Laboratory.IGG < 2000 AND NOT Examination.Symptoms IS NULL;

/*
Prediction Result:
(1,)
*/