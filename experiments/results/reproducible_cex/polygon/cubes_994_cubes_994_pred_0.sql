-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cname", "state", "enr") VALUES ('12', NULL, 853);
INSERT INTO "College" ("cname", "state", "enr") VALUES ('11', '20', 852);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (13, '853', '853', 853);
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (13, '11', '853', '853');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM (SELECT cname, state, enr, MAX(enr) OVER () AS maxenr FROM college) WHERE (maxenr > enr) ORDER BY state;

/*
Gold Result:
('20',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college WHERE enr < (SELECT MAX(enr) FROM college);

/*
Prediction Result:
('20',)
*/