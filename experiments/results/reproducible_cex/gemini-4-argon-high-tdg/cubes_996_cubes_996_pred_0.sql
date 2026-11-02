-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Cornell', 'NY', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 5000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('UCLA', 'CA', 30000);
INSERT INTO College (cName, state, enr) VALUES ('NYU', 'NY', 25000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102, 'Bob', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (103, 'Charlie', 'no', 1500);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Stanford', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Cornell', 'midfield', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr AS min_enr_ FROM (SELECT cname, state, MIN(enr) AS enr FROM college GROUP BY cname, state) ORDER BY cname, state NULLS LAST, min_enr_ NULLS LAST;

/*
Gold Result:
('Cornell', 'NY', 15000.0)
('MIT', 'MA', 5000.0)
('NYU', 'NY', 25000.0)
('Stanford', 'CA', 10000.0)
('UCLA', 'CA', 30000.0)
*/

-- Prediction Query
SELECT cName, state, MIN(enr) FROM college GROUP BY state;

/*
Prediction Result:
('Stanford', 'CA', 10000.0)
('MIT', 'MA', 5000.0)
('Cornell', 'NY', 15000.0)
*/