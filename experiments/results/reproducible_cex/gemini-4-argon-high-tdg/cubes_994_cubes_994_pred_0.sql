-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A_Col', 'TX', 2000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('B_Col', 'CA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_Col', 'NY', 3000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('D_Col', 'CA', 2500);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('E_Col', 'TX', 5000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 800);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'A_Col', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'A_Col', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'B_Col', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'E_Col', 'defense', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM (SELECT cname, state, enr, MAX(enr) OVER () AS maxenr FROM college) WHERE (maxenr > enr) ORDER BY state;

/*
Gold Result:
('CA',)
('CA',)
('NY',)
('TX',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college WHERE enr < (SELECT MAX(enr) FROM college);

/*
Prediction Result:
('TX',)
('CA',)
('NY',)
*/