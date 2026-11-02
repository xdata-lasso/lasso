-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. LEFT JOIN / OUTER JOIN mutants from College (Colleges with 0 tryouts must be excluded).
-- 2. Primary ORDER BY count___ ASC vs DESC (counts 1 and 2).
-- 3. Secondary ORDER BY cname ASC vs DESC (tie-breaker on count = 1 between 'MIT' and 'UCLA').
-- 4. Mutants filtering by decision = 'yes'/'no' or yCard = 'yes'/'no' (mix of decisions and cards).
-- 5. Mutants doing COUNT(DISTINCT pPos) or COUNT(decision) instead of COUNT(*) (NULLs and duplicate positions included).
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UCLA', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Harvard', 'MA', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Charlie', NULL, 800);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Stanford', 'goalie', NULL);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'UCLA', NULL, 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'MIT', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, cname FROM (SELECT cname, COUNT(*) AS n FROM tryout GROUP BY cname) ORDER BY count___, cname NULLS LAST;

/*
Gold Result:
(1, 'MIT')
(1, 'UCLA')
(2, 'Stanford')
*/

-- Prediction Query
SELECT COUNT(*), cName FROM tryout GROUP BY cName ORDER BY COUNT(*) DESC, cName NULLS LAST;

/*
Prediction Result:
(2, 'Stanford')
(1, 'MIT')
(1, 'UCLA')
*/