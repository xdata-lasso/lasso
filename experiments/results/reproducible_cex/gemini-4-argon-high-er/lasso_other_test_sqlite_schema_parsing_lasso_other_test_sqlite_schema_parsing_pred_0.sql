-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (CDSCode, County) VALUES ('1', 'CountyA');
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('1', '2020-2021', 5678);
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
('2020-2021',)
*/