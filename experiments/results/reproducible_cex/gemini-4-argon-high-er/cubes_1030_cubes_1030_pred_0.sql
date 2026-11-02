-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'B', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'A', 'no', 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname, hs FROM player WHERE (hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('A', 1000.0)
('B', 1000.0)
*/

-- Prediction Query
SELECT pName, HS FROM Player WHERE HS < 1500;

/*
Prediction Result:
('B', 1000.0)
('A', 1000.0)
*/