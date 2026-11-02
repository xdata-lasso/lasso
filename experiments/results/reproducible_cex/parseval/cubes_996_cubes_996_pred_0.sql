-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_ebec37', 'col_9dce83', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_f04861', 'col_9dce83', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_1d5cf8', 'col_9dce83', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('@', 'col_9dce83', 2.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('A', 'col_9dce83', 3.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('P', 'e4', 6.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('value', 'col_9a106f', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('B', 'val_1', NULL);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('H', NULL, 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr AS min_enr_ FROM (SELECT cname, state, MIN(enr) AS enr FROM college GROUP BY cname, state) ORDER BY cname, state NULLS LAST, min_enr_ NULLS LAST;

/*
Gold Result:
('@', 'col_9dce83', 2.0)
('A', 'col_9dce83', 3.0)
('B', 'val_1', None)
('H', None, 9.0)
('P', 'e4', 6.0)
('col_1d5cf8', 'col_9dce83', 1.0)
('col_ebec37', 'col_9dce83', 1.0)
('col_f04861', 'col_9dce83', 1.0)
('value', 'col_9a106f', 1.0)
*/

-- Prediction Query
SELECT cName, state, MIN(enr) FROM college GROUP BY state;

/*
Prediction Result:
('H', None, 9.0)
('value', 'col_9a106f', 1.0)
('col_ebec37', 'col_9dce83', 1.0)
('P', 'e4', 6.0)
('B', 'val_1', None)
*/