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
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (-1, 10, '0001-01-01', '0001-01-01', '0001-01-01', 11, 12);
INSERT INTO PATIENT VALUES (0, 35, '0001-01-01', '0001-01-01', '0001-01-01', 36, 37);
INSERT INTO LABORATORY VALUES (0, '1992-06-12', 0, 9, 0, 0, 13, 14, 15, 0, 16, 17, 0, 0, 0, 0, 18, 19, 20, 21, 0, 22, 0, 23, 0, 0, 0, 24, 0, 0, 0, 25, 26, 27, 0, 0, 28, 29, 30, 31, 32, 33, 34, 0);
INSERT INTO LABORATORY VALUES (-1, '1992-06-13', 0, 0, 0, 0, 38, 39, 40, 0, 41, 42, 0, 0, 0, 0, 43, 44, 45, 46, 0, 47, 0, 48, 0, 0, 0, 49, 0, 0, 0, 50, 51, 52, 0, 0, 53, 54, 55, 56, 57, 58, 59, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.SEX FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GPT = 9.0 AND T2.Date = '1992-06-12';

/*
Gold Result:
('35',)
*/

-- Prediction Query
SELECT Patient.SEX FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.Date = '1992-06-12' AND Laboratory.GPT = 9 AND (Patient.SEX = 'M' OR Patient.SEX = 'F');

/*
Prediction Result:
*/