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
INSERT INTO EXAMINATION VALUES (0, '1997-01-02', 0, 0, 0, 0, 0, 0, 0, 0, 5794613236571608566, 0, 0);
INSERT INTO EXAMINATION VALUES (-1, '1997-01-02', 0, 0, 0, 0, 0, 0, 0, 0, 5794613236571608566, 0, 0);
INSERT INTO PATIENT VALUES (0, 12, '0001-01-01', '0001-01-01', '0001-01-01', 13, 14);
INSERT INTO PATIENT VALUES (-1, 37, '0001-01-01', '0001-01-01', '0001-01-01', 38, 39);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 15, 16, 17, 0, 18, 19, 0, 0, 0, 0, 20, 21, 22, 23, 0, 24, 0, 25, 0, 0, 0, 26, 0, 0, 0, 27, 28, 29, 0, 0, 30, 31, 32, 33, 34, 35, 36, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 40, 41, 42, 0, 43, 44, 0, 0, 0, 0, 45, 46, 47, 48, 0, 49, 0, 50, 0, 0, 0, 51, 0, 0, 0, 52, 53, 54, 0, 0, 55, 56, 57, 58, 59, 60, 61, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date > '1997-01-01' AND T2.APTT >= 45;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination WHERE EXAMINATION_DATE > '1997-01-01' AND LAC = '+';

/*
Prediction Result:
(0,)
*/