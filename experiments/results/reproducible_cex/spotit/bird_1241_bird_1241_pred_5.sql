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
INSERT INTO PATIENT VALUES (0, 13, '0001-01-01', '0001-01-01', '0001-01-01', 14, 15);
INSERT INTO PATIENT VALUES (1, 38, '0001-01-01', '0001-01-01', '0001-01-01', 39, 40);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 16, 17, 18, 0, 19, 20, 0, 0, 0, 0, 21, 22, 23, 24, 399, 25, 0, 26, 0, 0, 0, 27, 0, 0, 0, 28, 29, 30, 0, 0, 31, 32, 33, 34, 35, 36, 37, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 41, 42, 43, 0, 44, 45, 0, 0, 0, 0, 46, 47, 48, 49, 101, 50, 0, 51, 0, 0, 0, 52, 0, 0, 0, 53, 54, 55, 0, 0, 56, 57, 58, 59, 60, 61, 62, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T2.PLT < 100 THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.PLT > 400 THEN 1 ELSE 0 END) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN laboratory.plt < 100 THEN 1 ELSE 0 END) - SUM(CASE WHEN laboratory.plt > 400 THEN 1 ELSE 0 END) AS difference FROM laboratory WHERE laboratory.plt <= 100 OR laboratory.plt >= 400;

/*
Prediction Result:
(None,)
*/