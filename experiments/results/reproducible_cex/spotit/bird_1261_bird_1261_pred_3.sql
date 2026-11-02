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
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 35, 36, 0, 37, 0, 38, 39, 40, 41, 42, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 64, 65, 0, 66, 0, 67, 68, 69, 70, 71, 0);
INSERT INTO PATIENT VALUES (-1, 0, '0001-01-01', '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO PATIENT VALUES (0, 0, '0001-01-01', '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 14, 15, 16, 0, 17, 18, 0, 0, 0, 0, 19, 20, 21, 22, 0, 23, 0, 24, 0, 0, 0, 25, 0, 0, 0, 26, 27, 0, 0, 0, 28, 29, 30, 31, 32, 33, 34, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 43, 44, 45, 0, 46, 47, 0, 0, 0, 0, 48, 49, 50, 51, 0, 52, 0, 53, 0, 0, 0, 54, 0, 0, 0, 55, 56, 0, 0, 0, 57, 58, 59, 60, 61, 62, 63, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.RF < 20 AND T1.Thrombosis = 0;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS patients_count FROM Laboratory AS L INNER JOIN Examination AS E ON L.ID = E.ID WHERE L.RF < 20 AND E.Thrombosis = '0';

/*
Prediction Result:
(2,)
*/