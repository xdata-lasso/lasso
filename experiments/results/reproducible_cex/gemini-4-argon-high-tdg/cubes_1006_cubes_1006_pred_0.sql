-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 17000);
INSERT INTO College (cName, state, enr) VALUES ('UCLA', 'CA', 31000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 11000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (10, 'Zane', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (20, 'Alice', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (30, 'Bob', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (40, 'Charlie', 'yes', 900);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (50, 'David', 'no', 1100);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (60, 'Eve', 'yes', 1000);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (10, 'Stanford', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (20, 'UCLA', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (30, 'MIT', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (40, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (50, 'UCLA', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."pname" AS "pname", "LHS"."ycard" AS "ycard", "LHS"."hs" AS "hs", "RHS"."cname" AS "cname", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "player" AS "LHS" INNER JOIN (SELECT * FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'striker')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY pname, "pname" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zane',)
*/

-- Prediction Query
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes' AND T2.pPos = 'striker';

/*
Prediction Result:
('Zane',)
('Alice',)
*/