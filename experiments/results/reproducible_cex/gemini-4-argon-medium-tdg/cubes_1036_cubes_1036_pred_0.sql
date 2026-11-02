-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'NY', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'CA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 36000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Cornell', 'TX', 20000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM college ORDER BY state, college.cname NULLS LAST;

/*
Gold Result:
('CA',)
('CA',)
('NY',)
('TX',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName;

/*
Prediction Result:
*/