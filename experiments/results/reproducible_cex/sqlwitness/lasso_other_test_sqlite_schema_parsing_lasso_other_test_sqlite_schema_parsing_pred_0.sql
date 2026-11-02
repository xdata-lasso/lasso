-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO schools (cdscode, county) VALUES ('default1', 'default2'), ('default2', 'default1');
INSERT INTO frpm (cdscode, "academic year", "district code") VALUES ('default2', 'default2', 1234), ('default2', 'default1', 1233);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('default1',)
('default2',)
*/