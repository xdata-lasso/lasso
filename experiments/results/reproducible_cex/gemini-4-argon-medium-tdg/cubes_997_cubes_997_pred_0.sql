-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('UCLA', 'CA', 30000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('Harvard', 'MA', 20000);
INSERT INTO College (cName, state, enr) VALUES ('UT', 'TX', 50000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Charles', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Charles', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'David', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'charles', 'no', 1000);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'MIT', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'UCLA', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'UT', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'Harvard', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "LHS"."pid" AS "pid", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "RHS"."pid" AS "pid", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "college" AS "LHS" INNER JOIN "tryout" AS "RHS" ON ("LHS"."cname" = "RHS"."cname")) AS "LHS" INNER JOIN (SELECT * FROM "player" WHERE ("pname" = 'Charles')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('CA',)
('MA',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName JOIN player AS T3 ON T2.pID = T3.pID WHERE T3.pName = 'Charles';

/*
Prediction Result:
('MA',)
('CA',)
('CA',)
*/