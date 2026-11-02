-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cname", "state", "enr") VALUES ('12', '20', 17);
INSERT INTO "College" ("cname", "state", "enr") VALUES ('9', '20', 20);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (10, '20', '20', 20);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (11, '20', '20', 20);
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (11, '12', '18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM college ORDER BY state, college.cname NULLS LAST;

/*
Gold Result:
('20',)
('20',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName;

/*
Prediction Result:
('20',)
*/