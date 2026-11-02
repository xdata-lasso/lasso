-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ties for the global maximum enrollment among multiple non-FL colleges and one FL college, plus ORDER BY sorting and NULL handling.
-- Kills mutants using LIMIT 1, wrong ORDER BY direction, wrong state filter (e.g. = 'FL' or OR instead of AND), or partitioning by state.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Zeta_Univ', 'NY', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Alpha_Univ', 'CA', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('FSU', 'FL', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Beta_Univ', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Null_State_Univ', NULL, 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Null_Enr_Univ', 'TX', NULL);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Bob', 'yes', 1200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Alpha_Univ', 'striker', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT "cname", "state", "enr", MAX("enr") OVER () AS "maxenr" FROM "college") WHERE ("state" <> 'FL' AND maxenr = enr) ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('Alpha_Univ',)
('Zeta_Univ',)
*/

-- Prediction Query
SELECT cName FROM college WHERE enr > (SELECT MAX(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/