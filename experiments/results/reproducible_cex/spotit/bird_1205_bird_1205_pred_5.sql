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
INSERT INTO EXAMINATION VALUES (57265, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO EXAMINATION VALUES (57265, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (57265, 9, '0001-01-01', '0001-01-01', '0001-01-01', 10, 11);
INSERT INTO PATIENT VALUES (57266, 34, '0001-01-01', '0001-01-01', '0001-01-01', 35, 36);
INSERT INTO LABORATORY VALUES (57265, '0001-01-01', 0, 0, 0, 0, 12, 13, 14, 0, 15, 16, 0, 0, 0, 0, 17, 18, 19, 20, 0, 21, 0, 22, 0, 0, 0, 23, 0, 0, 0, 24, 25, 26, 0, 0, 27, 28, 29, 30, 31, 32, 33, 0);
INSERT INTO LABORATORY VALUES (57266, '0001-01-02', 0, 0, 0, 0, 37, 38, 0, 0, 39, 40, 0, 0, 0, 0, 41, 42, 43, 44, 0, 45, 0, 46, 0, 0, 0, 47, 0, 0, 0, 48, 49, 50, 0, 0, 51, 52, 53, 54, 55, 56, 57, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN (T1.SEX = 'F' AND T2.UA > 6.5) OR (T1.SEX = 'M' AND T2.UA < 8.0) THEN TRUE ELSE FALSE END FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T1.ID = 57266;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CASE WHEN (patient.sex = 'M' AND laboratory.ua > 8.0) OR (patient.sex = 'F' AND laboratory.ua > 6.5) THEN 'Yes' ELSE 'No' END AS is_within_normal_range FROM patient INNER JOIN laboratory ON patient.id = laboratory.id WHERE patient.id = 57266;

/*
Prediction Result:
('No',)
*/