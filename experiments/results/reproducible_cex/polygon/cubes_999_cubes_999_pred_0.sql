-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cname", "state", "enr") VALUES ('FL8', 'FL', NULL);
INSERT INTO "College" ("cname", "state", "enr") VALUES ('FL7', 'FL', NULL);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (10, 'FL', 'FL', 2520324207979228216);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (9, 'FL', 'FL', 2520324207979228216);
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (9, 'FL7', 'FL', 'FL');
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (9, 'FL8', 'FL', 'FL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enr" AS "avg_enr_" FROM "college" WHERE ("state" = 'FL') ORDER BY avg_enr_, college.cname NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT AVG(enr) FROM College WHERE state = 'FL';

/*
Prediction Result:
(None,)
*/