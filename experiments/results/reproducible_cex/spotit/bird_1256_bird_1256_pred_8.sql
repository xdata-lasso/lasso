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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (0, 37, '0001-01-01', NULL, '0001-01-01', 38, 39);
INSERT INTO PATIENT VALUES (1, 40, '0001-01-01', '0001-01-01', '0001-01-01', 41, 42);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 16, 17, 18, 0, 19, 20, 0, 0, 0, 0, 21, 22, 23, 24, 0, 25, 0, 26, 0, 0, 0, 27, 0, 0, 0, 1584072942896526777, 28, 29, 0, 0, 30, 31, 32, 33, 34, 35, 36, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 50, 51, 52, 0, 53, 54, 0, 0, 0, 0, 55, 56, 57, 58, 0, 59, 0, 60, 0, 0, 0, 61, 0, 0, 0, 1584072942896526777, 62, 63, 0, 0, 64, 65, 66, 67, 68, 69, 70, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE (T2.CRP = '-' OR T2.CRP = '+-' OR T2.CRP < 1.0) AND T1.Description IS NULL;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Laboratory AS l LEFT JOIN Patient AS p ON l.ID = p.ID WHERE l.CRP = '+' AND p.Description IS NULL;

/*
Prediction Result:
(0,)
*/