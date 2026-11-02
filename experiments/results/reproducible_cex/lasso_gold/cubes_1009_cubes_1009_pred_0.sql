-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Allison Hill', 'Alaska', 1001.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Noah Rhodes', 'Oklahoma', 1008.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Angie Henderson', 'Illinois', 1015.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Daniel Wagner', 'Virginia', 1022.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT "cname", "state", "enr", MIN("enr") OVER () AS "minenr" FROM "college") WHERE ("state" <> 'FL' OR minenr = enr)) ORDER BY enr DESC) LIMIT 1);

/*
Gold Result:
('Daniel Wagner',)
*/

-- Prediction Query
SELECT DISTINCT cName FROM college WHERE enr > (SELECT MIN(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/