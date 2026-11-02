-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_4ff961', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_60b1f0', 'A', 2.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_d96903', 'e4', 3.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_3bc072', 'A', 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT "cname", "state", "enr", MIN("enr") OVER () AS "minenr" FROM "college") WHERE ("state" <> 'FL' OR minenr = enr)) ORDER BY enr DESC) LIMIT 1);

/*
Gold Result:
('col_d96903',)
*/

-- Prediction Query
SELECT DISTINCT cName FROM college WHERE enr > (SELECT MIN(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/