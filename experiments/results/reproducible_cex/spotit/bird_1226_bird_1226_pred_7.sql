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
INSERT INTO EXAMINATION VALUES (-2, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO EXAMINATION VALUES (-1, '0001-01-01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PATIENT VALUES (-2, 42, '0001-01-02', '0001-01-01', '0001-01-01', 43, 44);
INSERT INTO PATIENT VALUES (-1, 67, '0001-01-01', '0001-01-01', '0001-01-01', 68, 69);
INSERT INTO LABORATORY VALUES (-2, '0001-01-01', 0, 0, 0, 0, 45, 46, 47, 0, 48, 49, 1, 0, 0, 0, 50, 51, 52, 53, 0, 54, 0, 55, 0, 0, 0, 56, 0, 0, 0, 57, 58, 59, 0, 0, 60, 61, 62, 63, 64, 65, 66, 0);
INSERT INTO LABORATORY VALUES (-1, '0001-01-02', 0, 0, 0, 0, 70, 71, 72, 0, 73, 74, 0, 0, 0, 0, 75, 76, 77, 78, 0, 79, 0, 80, 0, 0, 0, 81, 0, 0, 0, 82, 83, 84, 0, 0, 85, 86, 87, 88, 89, 90, 91, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ID, T2.T_CHO FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID ORDER BY T2.T_CHO DESC, T1.Birthday ASC, T1.id NULLS LAST, T2.id NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Gold Result:
(-2, 1)
*/

-- Prediction Query
SELECT P.ID, L.T_CHO FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.Birthday = (SELECT MIN(Birthday) FROM Patient) AND L.T_CHO = (SELECT MAX(L2.T_CHO) FROM Laboratory AS L2 INNER JOIN Patient AS P2 ON L2.ID = P2.ID WHERE P2.Birthday = (SELECT MIN(Birthday) FROM Patient));

/*
Prediction Result:
(-1, 0)
*/