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
INSERT INTO EXAMINATION VALUES (0, '1997-01-01', 18, 19, 0, 20, 0, 21, 22, 23, 24, 25, 0);
INSERT INTO EXAMINATION VALUES (0, '1997-01-02', 49, 50, 0, 51, 0, 52, 53, 54, 55, 56, 0);
INSERT INTO PATIENT VALUES (0, 79, '0001-01-01', '0001-01-01', '0001-01-01', 80, 81);
INSERT INTO PATIENT VALUES (-1, 82, '0001-01-01', '0001-01-01', '0001-01-01', 83, 84);
INSERT INTO LABORATORY VALUES (-1, '1997-01-02', 0, 0, 0, 0, 26, 27, 28, 0, 29, 30, 0, 0, 0, 0, 31, 32, 33, 34, 0, 35, 45, 36, 0, 0, 0, 37, 0, 0, 0, 38, 39, 40, 0, 0, 41, 42, 43, 44, 46, 47, 48, 0);
INSERT INTO LABORATORY VALUES (0, '1997-01-03', 0, 0, 0, 0, 57, 58, 59, 0, 60, 61, 0, 0, 0, 0, 62, 63, 64, 65, 0, 66, 45, 67, 0, 0, 0, 68, 0, 0, 0, 69, 70, 71, 0, 0, 72, 73, 74, 75, 76, 77, 78, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.Date > '1997-01-01' AND T2.APTT >= 45;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) - (SELECT COUNT(*) FROM Examination AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.EXAMINATION_DATE > '1997-01-01' AND T2.APTT < 45) AS Inactivated_Partial_Protehembin_Time FROM Examination AS T1 JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.EXAMINATION_DATE > '1997-01-01';

/*
Prediction Result:
(1,)
*/