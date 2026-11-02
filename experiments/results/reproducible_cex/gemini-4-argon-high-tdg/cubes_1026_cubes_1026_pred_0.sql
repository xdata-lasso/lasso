-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Tulane', 'LA', 8000.0);
INSERT INTO College (cName, state, enr) VALUES ('LSU', 'LA', 25000.0);
INSERT INTO College (cName, state, enr) VALUES ('Xavier', 'LA', 12000.0);
INSERT INTO College (cName, state, enr) VALUES ('Centenary', 'LA', 12000.0);
INSERT INTO College (cName, state, enr) VALUES ('Grambling', 'LA', 10000.0);
INSERT INTO College (cName, state, enr) VALUES ('UT', 'TX', 15000.0);
INSERT INTO College (cName, state, enr) VALUES ('Baylor', 'TX', 10000.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101.0, 'Alice', 'no', 1200.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102.0, 'Bob', 'yes', 800.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (103.0, 'Charlie', 'no', 1500.0);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101.0, 'LSU', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102.0, 'LSU', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103.0, 'Tulane', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101.0, 'Grambling', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102.0, 'UT', 'mid', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname", "enr" FROM "college" WHERE ("state" = 'LA' AND enr <> 10000.0) ORDER BY cname;

/*
Gold Result:
('Centenary', 12000.0)
('LSU', 25000.0)
('Tulane', 8000.0)
('Xavier', 12000.0)
*/

-- Prediction Query
SELECT cName, enr FROM College WHERE enr > 10000 AND state = 'LA';

/*
Prediction Result:
('LSU', 25000.0)
('Xavier', 12000.0)
('Centenary', 12000.0)
*/