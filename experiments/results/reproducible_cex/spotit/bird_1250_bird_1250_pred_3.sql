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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO EXAMINATION VALUES (1, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (0, 33, '0001-01-01', '0001-01-01', '0001-01-01', 34, 35);
INSERT INTO PATIENT VALUES (1, 57, '0001-01-01', '0001-01-01', '0001-01-01', 58, 250759877463766969);
INSERT INTO LABORATORY VALUES (1, '0001-01-01', 0, 0, 0, 0, 10, 11, 12, 0, 13, 14, 0, 0, 0, 0, 15, 16, 17, 18, 0, 19, 0, 20, 0, 0, 0, 30, 0, 0, 0, 21, 22, 23, 0, 0, 24, 25, 26, 27, 28, 29, 32, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 36, 37, 38, 0, 39, 40, 0, 0, 0, 0, 41, 42, 43, 44, 0, 45, 0, 46, 0, 0, 0, 31, 0, 0, 0, 47, 48, 49, 0, 0, 50, 51, 52, 53, 54, 55, 56, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.U_PRO > 0 AND T2.U_PRO < 30 AND T1.Diagnosis = 'SLE';

/*
Gold Result:
*/

-- Prediction Query
SELECT Patient.ID FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.U_PRO BETWEEN 0 AND 30 AND Patient.Diagnosis = 'SLE';

/*
Prediction Result:
*/