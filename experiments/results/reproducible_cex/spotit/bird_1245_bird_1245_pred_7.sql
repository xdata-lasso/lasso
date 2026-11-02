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
INSERT INTO EXAMINATION VALUES (0, '1997-01-02', 15, 16, 0, 17, 0, 18, 19, 20, 21, 22, 0);
INSERT INTO EXAMINATION VALUES (0, '1997-01-02', 45, 46, 0, 47, 0, 48, 49, 50, 51, 52, 0);
INSERT INTO PATIENT VALUES (0, 75, '0001-01-01', '0001-01-01', '0001-01-01', 76, 77);
INSERT INTO PATIENT VALUES (-1, 78, '0001-01-01', '0001-01-01', '0001-01-01', 79, 80);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 23, 24, 25, 0, 26, 27, 0, 0, 0, 0, 28, 29, 30, 31, 0, 32, 0, 33, 0, 0, 0, 34, 0, 0, 0, 35, 36, 37, 0, 0, 38, 39, 40, 41, 42, 43, 44, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 53, 54, 55, 0, 56, 57, 0, 0, 0, 0, 58, 59, 60, 61, 0, 62, 0, 63, 0, 0, 0, 64, 0, 0, 0, 65, 66, 67, 0, 0, 68, 69, 70, 71, 72, 73, 74, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date > '1997-01-01' AND T2.APTT >= 45;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Examination AS E JOIN Laboratory AS L ON E.ID = L.ID WHERE E.EXAMINATION_DATE > '1997-01-01' AND L.APTT < 45;

/*
Prediction Result:
(4,)
*/