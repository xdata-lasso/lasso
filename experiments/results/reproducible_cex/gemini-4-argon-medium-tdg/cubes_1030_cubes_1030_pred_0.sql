-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate (pName, HS) pairs to catch mutants that mistakenly add DISTINCT, and tests tie-breaking by pID
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (30, 'Zane', 'no', 1000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (10, 'Aaron', 'yes', 1200.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (20, 'Aaron', 'no', 1200.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (15, 'Aaron', 'yes', 800.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (5, 'Beth', 'no', 1400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname, hs FROM player WHERE (hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Aaron', 1200.0)
('Aaron', 800.0)
('Aaron', 1200.0)
('Beth', 1400.0)
('Zane', 1000.0)
*/

-- Prediction Query
SELECT pName, HS FROM Player WHERE HS < 1500;

/*
Prediction Result:
('Zane', 1000.0)
('Aaron', 1200.0)
('Aaron', 1200.0)
('Aaron', 800.0)
('Beth', 1400.0)
*/