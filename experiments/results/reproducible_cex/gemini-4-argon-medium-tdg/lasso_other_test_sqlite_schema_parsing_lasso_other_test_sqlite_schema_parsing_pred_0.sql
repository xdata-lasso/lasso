-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, County) VALUES ('S1', 'Alameda');
INSERT INTO schools (CDSCode, County) VALUES ('S2', 'Los Angeles');
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S1', '2020-2021', 1234);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S1', '2021-2022', 1233);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S1', '2022-2023', 1235);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S2', '2019-2020', NULL);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S2', '2018-2019', -1234);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
('2020-2021',)
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('2020-2021',)
('2021-2022',)
('2022-2023',)
('2018-2019',)
('2019-2020',)
*/