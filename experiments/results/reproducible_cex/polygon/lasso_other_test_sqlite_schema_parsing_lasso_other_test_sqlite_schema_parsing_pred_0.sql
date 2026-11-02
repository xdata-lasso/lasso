-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "schools" ("cdscode", "county") VALUES ('5', '7');
INSERT INTO "schools" ("cdscode", "county") VALUES ('6', '7');
INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('5', '7', 8);
INSERT INTO "frpm" ("cdscode", "academic year", "district code") VALUES ('6', '7', 1234);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
('7',)
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('7',)
('7',)
*/