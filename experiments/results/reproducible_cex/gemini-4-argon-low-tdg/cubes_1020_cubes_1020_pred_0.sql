-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Out-of-order insertion (verifies ORDER BY cName vs insertion order)
-- 2. Anticorrelated sort orders across columns (cName ASC != state ASC != enr ASC)
-- 3. Unreferenced parent row ('Berkeley' has no Tryouts - kills INNER JOIN Tryout mutants)
-- 4. Multiply-referenced parent row ('Yale' has 2 Tryouts - kills non-DISTINCT JOIN Tryout mutants)
-- 5. Boundary and standard enrollment values (0, 1000, 15000, 50000) to kill arbitrary WHERE filters
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Yale', 'CT', 5000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 35000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Auburn', 'AL', 50000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'NY', 0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (101, 'Alice', 'no', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (102, 'Bob', 'yes', 800);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Yale', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'Yale', 'striker', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'MIT', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'Auburn', 'defense', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Stanford', 'goalie', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr FROM college ORDER BY cname;

/*
Gold Result:
('Auburn', 'AL', 50000.0)
('Berkeley', 'CA', 35000.0)
('MIT', 'MA', 1000.0)
('Stanford', 'NY', 0.0)
('Yale', 'CT', 5000.0)
*/

-- Prediction Query
SELECT * FROM College ORDER BY enr, College.cname NULLS LAST;

/*
Prediction Result:
('Stanford', 'NY', 0.0)
('MIT', 'MA', 1000.0)
('Yale', 'CT', 5000.0)
('Berkeley', 'CA', 35000.0)
('Auburn', 'AL', 50000.0)
*/