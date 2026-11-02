-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Lance Hoffman', 'Indiana', 1003.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Javier Johnson', 'Virginia', 1004.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr FROM college ORDER BY cname;

/*
Gold Result:
('Javier Johnson', 'Virginia', 1004.5)
('Lance Hoffman', 'Indiana', 1003.5)
*/

-- Prediction Query
SELECT * FROM College ORDER BY enr, College.cname NULLS LAST;

/*
Prediction Result:
('Lance Hoffman', 'Indiana', 1003.5)
('Javier Johnson', 'Virginia', 1004.5)
*/