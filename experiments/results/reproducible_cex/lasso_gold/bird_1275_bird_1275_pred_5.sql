-- Schema DDL
CREATE TABLE Examination (ID INTEGER NULL, "Examination Date" DATE NULL, "aCL IgG" REAL NULL, "aCL IgM" REAL NULL, ANA INTEGER NULL, "ANA Pattern" TEXT NULL, "aCL IgA" INTEGER NULL, Diagnosis TEXT NULL, KCT TEXT NULL, RVVT TEXT NULL, LAC TEXT NULL, Symptoms TEXT NULL, Thrombosis INTEGER NULL, FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

CREATE TABLE Patient (ID INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, SEX TEXT NULL, Birthday DATE NULL, Description DATE NULL, "First Date" DATE NULL, Admission TEXT NULL, Diagnosis TEXT NULL);

CREATE TABLE Laboratory (ID INTEGER DEFAULT 0 NOT NULL, Date DATE DEFAULT '0000-00-00' NOT NULL, GOT INTEGER NULL, GPT INTEGER NULL, LDH INTEGER NULL, ALP INTEGER NULL, TP REAL NULL, ALB REAL NULL, UA REAL NULL, UN INTEGER NULL, CRE REAL NULL, "T-BIL" REAL NULL, "T-CHO" INTEGER NULL, TG INTEGER NULL, CPK INTEGER NULL, GLU INTEGER NULL, WBC REAL NULL, RBC REAL NULL, HGB REAL NULL, HCT REAL NULL, PLT INTEGER NULL, PT REAL NULL, APTT INTEGER NULL, FG REAL NULL, PIC INTEGER NULL, TAT INTEGER NULL, TAT2 INTEGER NULL, "U-PRO" TEXT NULL, IGG INTEGER NULL, IGA INTEGER NULL, IGM INTEGER NULL, CRP TEXT NULL, RA TEXT NULL, RF TEXT NULL, C3 INTEGER NULL, C4 INTEGER NULL, RNP TEXT NULL, SM TEXT NULL, SC170 TEXT NULL, SSA TEXT NULL, SSB TEXT NULL, CENTROMEA TEXT NULL, DNA TEXT NULL, "DNA-II" INTEGER NULL, PRIMARY KEY (ID, Date), FOREIGN KEY (ID) REFERENCES Patient (ID) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "patient" ("id", "sex", "birthday", "description", "first date", "admission", "diagnosis") VALUES (1643, 'M', '1991-07-05', '1992-08-06', '1993-09-07', 'brother', 'finally');
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1643, '1994-10-08', 1645, 1647, 1649, 1651, 1653.5, 1655.5, 1657.5, 1659, 1661.5, 1663.5, 1665, 1667, 1669, 1671, 1673.5, 1675.5, 1677.5, 1679.5, 1681, 1683.5, 1685, 1687.5, 1689, 1691, 1693, 'negative', 1695, 1697, 1699, 'negative', 'negative', 'negative', 1701, 1703, 'negative', 'negative', 'negative', 'negative', 'negative', 'grow', 'negative', 1705);
INSERT INTO "laboratory" ("id", "date", "got", "gpt", "ldh", "alp", "tp", "alb", "ua", "un", "cre", "t-bil", "t-cho", "tg", "cpk", "glu", "wbc", "rbc", "hgb", "hct", "plt", "pt", "aptt", "fg", "pic", "tat", "tat2", "u-pro", "igg", "iga", "igm", "crp", "ra", "rf", "c3", "c4", "rnp", "sm", "sc170", "ssa", "ssb", "centromea", "dna", "dna-ii") VALUES (1643, '1994-10-09', 1652.0, 1656.0, 1660.0, 1664.0, 1668.5, 1672.5, 1676.5, 1680.0, 1684.5, 1688.5, 1692.0, 1696.0, 1700.0, 1704.0, 1708.5, 1712.5, 1716.5, 1720.5, 1724.0, 1728.5, 1732.0, 1736.5, 1740.0, 1744.0, 1748.0, 'negative', 1754.0, 1758.0, 1762.0, 'negative', 'negative', 'negative', 1772.0, 1776.0, 'negative', 'negative', 'negative', 'negative', '0', 'grow', 'negative', 1794.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.ID) FROM Patient AS T1 INNER JOIN Laboratory AS T2 ON T1.ID = T2.ID WHERE T2.CENTROMEA IN ('negative', '0') AND T2.SSB IN ('negative', '0') AND T1.SEX = 'M';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT P.ID) AS COUNT FROM Patient AS P INNER JOIN Laboratory AS L ON P.ID = L.ID WHERE P.SEX = 'M' AND NOT L.CENTROMEA IN ('-', '+-') AND NOT L.SSB IN ('-', '+-');

/*
Prediction Result:
(1,)
*/