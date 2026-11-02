-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Alpha', 'NY', 20000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Metro', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Palm', 'FL', 50000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Zeta', 'TX', 10000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (101, 'Alex', 'no', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (102, 'Sam', 'yes', 950);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Alpha', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Palm', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'Zeta', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT "cname", "state", "enr", MIN("enr") OVER () AS "minenr" FROM "college") WHERE ("state" <> 'FL' OR minenr = enr)) ORDER BY enr DESC) LIMIT 1);

/*
Gold Result:
('Metro',)
*/

-- Prediction Query
SELECT DISTINCT cName FROM college WHERE enr > (SELECT MIN(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/