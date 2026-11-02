-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A', 'CA', 200);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('B', 'NY', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr FROM college ORDER BY cname;

/*
Gold Result:
('A', 'CA', 200.0)
('B', 'NY', 100.0)
*/

-- Prediction Query
SELECT * FROM College ORDER BY enr, College.cname NULLS LAST;

/*
Prediction Result:
('B', 'NY', 100.0)
('A', 'CA', 200.0)
*/