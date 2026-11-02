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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 12, 13, 0, 14, 0, 15, 16, 17, 18, 19, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 20, 21, 0, 22, 0, 23, 24, 25, 26, 27, 0);
INSERT INTO PATIENT VALUES (0, 73, '0001-01-01', '0001-01-01', '0001-01-01', 74, 75);
INSERT INTO PATIENT VALUES (1, 76, '0001-01-01', '0001-01-01', '0001-01-01', 77, 78);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 29, 30, 31, 0, 32, 33, 0, 0, 0, 179, 34, 35, 36, 37, 0, 38, 0, 39, 0, 0, 0, 40, 0, 0, 0, 41, 42, 43, 0, 0, 44, 45, 46, 47, 48, 49, 50, 0);
INSERT INTO LABORATORY VALUES (0, '0001-01-02', 0, 0, 0, 0, 51, 52, 53, 0, 54, 55, 0, 0, 0, 179, 56, 57, 58, 59, 0, 60, 0, 61, 0, 0, 0, 62, 0, 0, 0, 63, 64, 65, 0, 0, 66, 67, 68, 69, 70, 71, 72, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID INNER JOIN Examination AS T3 ON T1.ID = T3.ID WHERE T2.GLU < 180 AND T3.Thrombosis = 0;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT lab.id) FROM laboratory AS lab INNER JOIN examination AS exam ON lab.id = exam.id WHERE lab.glu < 180 AND exam.thrombosis = 0;

/*
Prediction Result:
(1,)
*/