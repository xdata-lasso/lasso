-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_1', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_26f48f', 'FL', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('A', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('C', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_17284b', 'FL', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_6', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_7', 'e4', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('@', NULL, 8.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('H', 'FL', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enr" AS "avg_enr_" FROM "college" WHERE ("state" = 'FL') ORDER BY avg_enr_, college.cname NULLS LAST;

/*
Gold Result:
(None,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT AVG(enr) FROM College WHERE state = 'FL';

/*
Prediction Result:
(1.0,)
*/