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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 11, 12, 0, 13, 0, 14, 15, 16, 17, 18, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 19, 20, 0, 21, 0, 22, 23, 24, 25, 26, 0);
INSERT INTO PATIENT VALUES (0, 31, '0001-01-01', '0001-01-01', '0001-01-01', 32, 33);
INSERT INTO PATIENT VALUES (-1, 56, '0001-01-01', '0001-01-01', '0001-01-01', 57, 58);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 34, 35, 36, 0, 37, 38, 0, 199, 0, 0, 39, 40, 41, 42, 0, 43, 0, 44, 0, 0, 0, 45, 0, 0, 0, 46, 47, 48, 0, 0, 49, 50, 51, 52, 53, 54, 55, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 59, 60, 61, 0, 62, 63, 0, 199, 0, 0, 64, 65, 66, 67, 0, 68, 0, 69, 0, 0, 0, 70, 0, 0, 0, 71, 72, 73, 0, 0, 74, 75, 76, 77, 78, 79, 80, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Examination AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.TG < 200 AND NOT T1.Symptoms IS NULL;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.TG < 200 AND NOT T3.Symptoms IS NULL;

/*
Prediction Result:
(1,)
*/