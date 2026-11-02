-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('B', 'CA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A', 'NY', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'P2', 'no', 500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'B', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'A', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'goalie') ORDER BY cname, tryout.pid NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE decision = 'yes' AND pPos = 'goalie';

/*
Prediction Result:
('B',)
('A',)
*/