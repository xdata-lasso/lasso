-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "county") VALUES ('dog', 'chair');
INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('dog', 'since', 1235);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('since',)
*/