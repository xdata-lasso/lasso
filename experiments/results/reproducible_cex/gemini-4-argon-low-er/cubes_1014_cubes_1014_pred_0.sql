-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A', 'CA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('B', 'NY', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'P2', 'no', 600);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'A', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'B', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'B', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, cname FROM (SELECT cname, COUNT(*) AS n FROM tryout GROUP BY cname) ORDER BY count___, cname NULLS LAST;

/*
Gold Result:
(1, 'A')
(2, 'B')
*/

-- Prediction Query
SELECT COUNT(*), cName FROM tryout GROUP BY cName ORDER BY COUNT(*) DESC, cName NULLS LAST;

/*
Prediction Result:
(2, 'B')
(1, 'A')
*/