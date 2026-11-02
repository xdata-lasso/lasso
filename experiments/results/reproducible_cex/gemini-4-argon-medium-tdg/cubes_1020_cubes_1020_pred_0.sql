-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', 5000);
INSERT INTO College (cName, state, enr) VALUES ('Harvard', 'MA', 20000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102, 'Bob', 'yes', 800);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Harvard', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Harvard', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'MIT', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr FROM college ORDER BY cname;

/*
Gold Result:
('Harvard', 'MA', 20000.0)
('MIT', 'MA', 10000.0)
('Stanford', 'CA', 15000.0)
('Yale', 'CT', 5000.0)
*/

-- Prediction Query
SELECT * FROM College ORDER BY enr, College.cname NULLS LAST;

/*
Prediction Result:
('Yale', 'CT', 5000.0)
('MIT', 'MA', 10000.0)
('Stanford', 'CA', 15000.0)
('Harvard', 'MA', 20000.0)
*/