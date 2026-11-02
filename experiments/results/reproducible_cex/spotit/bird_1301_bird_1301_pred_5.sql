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
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 33, 34, 0, 35, 0, 36, 37, 38, 39, 40, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 63, 64, 0, 65, 0, 66, 67, 68, 69, 70, 0);
INSERT INTO PATIENT VALUES (-1, 0, '0001-01-01', '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO PATIENT VALUES (0, 0, '0001-01-01', '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO LABORATORY VALUES (-1, '0001-01-02', 0, 0, 0, 0, 11, 12, 13, 0, 14, 15, 0, 0, 251, 0, 16, 17, 18, 19, 0, 20, 0, 21, 0, 0, 0, 22, 0, 0, 0, 23, 24, 25, 0, 0, 26, 27, 28, 29, 30, 31, 32, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 41, 42, 43, 0, 44, 45, 0, 0, 0, 0, 46, 47, 48, 49, 0, 50, 0, 51, 0, 0, 0, 52, 0, 0, 0, 53, 54, 55, 0, 0, 56, 57, 58, 59, 60, 61, 62, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Laboratory AS T1 INNER JOIN Examination AS T2 ON T1.ID = T2.ID WHERE T2.Thrombosis = 0 AND T1.CPK < 250;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT laboratory.id FROM laboratory INNER JOIN examination ON laboratory.id = examination.id WHERE examination.thrombosis = 0 AND laboratory.cpk > 250;

/*
Prediction Result:
(-1,)
*/