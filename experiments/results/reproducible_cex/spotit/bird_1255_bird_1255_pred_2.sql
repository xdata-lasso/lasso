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
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 10, 400, 0, 11, 0, 12, 13, 14, 15, 16, 0);
INSERT INTO EXAMINATION VALUES (0, '0001-01-01', 27, 41, 0, 28, 0, 29, 30, 31, 32, 33, 0);
INSERT INTO PATIENT VALUES (-1, 25, '0001-01-01', '0001-01-01', '0001-01-01', 26, -3);
INSERT INTO PATIENT VALUES (0, 34, '0001-01-01', '0001-01-01', '0001-01-01', 35, -2);
INSERT INTO LABORATORY VALUES (0, '0001-01-01', 0, 0, 0, 0, 36, 37, 38, 0, 39, 40, 0, 0, 0, 0, 42, 43, 44, 45, 0, 46, 0, 47, 0, 0, 0, 48, 0, 0, 401, 49, 50, 51, 0, 0, 52, 53, 54, 55, 56, 57, 58, 0);
INSERT INTO LABORATORY VALUES (-1, '0001-01-02', 0, 0, 0, 0, 59, 60, 61, 0, 62, 63, 0, 0, 0, 0, 64, 65, 66, 67, 0, 68, 0, 69, 0, 0, 0, 70, 0, 0, 401, 71, 72, 73, 0, 0, 74, 75, 76, 77, 78, 79, 80, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Diagnosis FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE NOT T2.IGM BETWEEN 40 AND 400 GROUP BY T1.Diagnosis ORDER BY COUNT(T1.Diagnosis) DESC, T1.Diagnosis NULLS LAST LIMIT 1;

/*
Gold Result:
('-2',)
*/

-- Prediction Query
SELECT P.Diagnosis FROM Examination AS E INNER JOIN Patient AS P ON E.ID = P.ID WHERE (E.ACL_IGM <= 40 OR E.ACL_IGM >= 400) GROUP BY P.Diagnosis ORDER BY COUNT(*) DESC, P.Diagnosis NULLS LAST LIMIT 1;

/*
Prediction Result:
('-2',)
*/