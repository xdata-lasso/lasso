-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('FL' vs other states, case sensitivity, and NULL state) and basic ascending ORDER BY on enr.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UF', 'FL', 50000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('FSU', 'FL', 40000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UM', 'FL', 17000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UGA', 'GA', 38000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Rollins', 'fl', 3000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UnknownU', NULL, 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enr" AS "avg_enr_" FROM "college" WHERE ("state" = 'FL') ORDER BY avg_enr_, college.cname NULLS LAST;

/*
Gold Result:
(17000.0,)
(40000.0,)
(50000.0,)
*/

-- Prediction Query
SELECT AVG(enr) FROM College WHERE state = 'FL';

/*
Prediction Result:
(35666.666666666664,)
*/