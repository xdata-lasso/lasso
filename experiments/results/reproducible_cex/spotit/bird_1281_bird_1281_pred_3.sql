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
INSERT INTO PATIENT VALUES (0, 55, '0001-01-01', '0001-01-01', '0001-01-01', 56, 57);
INSERT INTO PATIENT VALUES (1, 81, '0001-01-02', '0001-01-01', '0001-01-01', 82, 83);
INSERT INTO LABORATORY VALUES (1, '0001-01-01', 60, 0, 0, 0, 33, 34, 35, 0, 36, 37, 0, 0, 0, 0, 38, 39, 40, 41, 0, 42, 0, 43, 0, 0, 0, 44, 0, 0, 0, 45, 46, 47, 0, 0, 48, 49, 50, 51, 52, 53, 54, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 60, 0, 0, 0, 58, 59, 61, 0, 62, 63, 0, 0, 0, 0, 64, 65, 66, 67, 0, 68, 0, 69, 0, 0, 0, 70, 0, 0, 0, 71, 72, 73, 0, 0, 74, 75, 76, 77, 78, 79, 80, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Birthday FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.GOT >= 60 ORDER BY T1.Birthday DESC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
('0001-01-02',)
*/

-- Prediction Query
SELECT Patient.Birthday FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.GOT >= 60 ORDER BY Patient.Birthday ASC, Laboratory.id NULLS LAST, Laboratory.date NULLS LAST, Patient.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0001-01-01',)
*/