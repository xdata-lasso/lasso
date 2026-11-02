-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_152871', 'LA', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('A', 'LA', 10000.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('@', 'LA', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('H', 'col_3e3a9a', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('B', 'col_3e3a9a', 10000.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('I', 'col_3e3a9a', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('C', NULL, 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('D', NULL, 10000.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('F', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname", "enr" FROM "college" WHERE ("state" = 'LA' AND enr <> 10000.0) ORDER BY cname;

/*
Gold Result:
('col_152871', 1.0)
*/

-- Prediction Query
SELECT cName, enr FROM College WHERE enr > 10000 AND state = 'LA';

/*
Prediction Result:
*/