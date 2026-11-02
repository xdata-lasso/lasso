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
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 11, 12, 0, 13, 0, 14, 15, 16, 17, 18, 0);
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 19, 20, 0, 21, 0, 22, 23, 24, 25, 26, 0);
INSERT INTO PATIENT VALUES (-1, 72, '0001-01-01', '0001-01-01', '0001-01-01', 73, 74);
INSERT INTO PATIENT VALUES (0, 75, '0001-01-01', '0001-01-01', '0001-01-01', 76, 77);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 28, 29, 30, 0, 31, 32, 0, 0, 0, 179, 33, 34, 35, 36, 0, 37, 0, 38, 0, 0, 0, 39, 0, 0, 0, 40, 41, 42, 0, 0, 43, 44, 45, 46, 47, 48, 49, 0);
INSERT INTO LABORATORY VALUES (-1, '0001-01-01', 0, 0, 0, 0, 50, 51, 52, 0, 53, 54, 0, 0, 0, 179, 55, 56, 57, 58, 0, 59, 0, 60, 0, 0, 0, 61, 0, 0, 0, 62, 63, 64, 0, 0, 65, 66, 67, 68, 69, 70, 71, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.GLU < 180 AND T3.Thrombosis = 0;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT e.ID) FROM Examination AS e JOIN Laboratory AS l ON e.ID = l.ID WHERE l.GLU < 180 AND e.Thrombosis = 0;

/*
Prediction Result:
(1,)
*/