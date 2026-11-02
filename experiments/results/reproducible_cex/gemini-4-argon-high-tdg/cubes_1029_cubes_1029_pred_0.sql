-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "College" ("cName", "state", "enr") VALUES ('FSU', 'FL', 45000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('ZetaCol', 'TX', 45000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('AlphaCol', 'MA', 45000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('BetaCol', 'OH', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (10, 'Bob', 'yes', 900);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (20, 'Charlie', 'no', 1500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (10, 'AlphaCol', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (20, 'AlphaCol', 'defense', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (10, 'ZetaCol', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (20, 'ZetaCol', 'mid', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT "cname", "state", "enr", MAX("enr") OVER () AS "maxenr" FROM "college") WHERE ("state" <> 'FL' AND maxenr = enr) ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('AlphaCol',)
('ZetaCol',)
*/

-- Prediction Query
SELECT cName FROM college WHERE enr > (SELECT MAX(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/