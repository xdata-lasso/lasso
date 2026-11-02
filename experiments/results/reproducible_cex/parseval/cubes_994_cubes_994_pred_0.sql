-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('_', 'col_2fab26', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('A', 'col_2fab26', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_3', 'e4', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_4', 'e4', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_5', NULL, 5.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_6', NULL, NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_7', NULL, NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('O', 'col_2fab26', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('@', 'e4', -1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('1', 'e4', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state FROM (SELECT cname, state, enr, MAX(enr) OVER () AS maxenr FROM college) WHERE (maxenr > enr) ORDER BY state;

/*
Gold Result:
('col_2fab26',)
('col_2fab26',)
('col_2fab26',)
('e4',)
('e4',)
*/

-- Prediction Query
SELECT DISTINCT state FROM college WHERE enr < (SELECT MAX(enr) FROM college);

/*
Prediction Result:
('col_2fab26',)
('e4',)
*/