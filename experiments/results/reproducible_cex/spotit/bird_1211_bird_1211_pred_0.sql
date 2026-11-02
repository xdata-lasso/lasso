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
INSERT INTO EXAMINATION VALUES (0, '0000-10-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO EXAMINATION VALUES (0, '0000-10-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (0, 21, '0002-03-01', '0000-11-01', '0000-06-01', 22, 23);
INSERT INTO PATIENT VALUES (1, 47, '0002-11-01', '0000-08-01', '0000-09-01', 48, 49);
INSERT INTO LABORATORY VALUES (1, '0000-04-01', 0, 0, 601, 0, 24, 25, 26, 0, 27, 28, 0, 0, 0, 0, 29, 30, 32, 33, 0, 34, 0, 35, 0, 0, 0, 36, 0, 0, 0, 37, 38, 39, 0, 0, 40, 41, 42, 43, 44, 45, 46, 0);
INSERT INTO LABORATORY VALUES (0, '0000-01-01', 0, 0, 800, 0, 50, 51, 52, 0, 53, 54, 0, 0, 0, 0, 55, 56, 57, 58, 0, 60, 0, 61, 0, 0, 0, 62, 0, 0, 0, 63, 64, 65, 0, 0, 66, 67, 68, 69, 70, 71, 72, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.ID, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T1.Birthday) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.LDH > 600 AND T2.LDH < 800;

/*
Gold Result:
(1, 2023)
*/

-- Prediction Query
SELECT p.ID, CAST((STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', p.Birthday)) AS REAL) AS age FROM Patient AS p JOIN Laboratory AS l ON p.ID = l.ID WHERE l.LDH BETWEEN 600 AND 800;

/*
Prediction Result:
(1, 2023.0)
(0, 2023.0)
*/