-- Schema DDL
CREATE TABLE schools (CDSCode TEXT PRIMARY KEY, County TEXT NOT NULL);

CREATE TABLE frpm (CDSCode TEXT REFERENCES schools (CDSCode), "Academic Year" TEXT, "District Code" INTEGER, PRIMARY KEY (CDSCode, "Academic Year"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO schools (CDSCode, County) VALUES ('S001', 'Alameda');
INSERT INTO schools (CDSCode, County) VALUES ('S002', 'Fresno');
INSERT INTO schools (CDSCode, County) VALUES ('S003', 'Kern');
INSERT INTO schools (CDSCode, County) VALUES ('S004', 'Marin');
INSERT INTO schools (CDSCode, County) VALUES ('S005', 'Napa');
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S001', '2020-2021', 1233);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S002', '2021-2022', 1234);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S003', '2022-2023', 1235);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S004', '2023-2024', 12345);
INSERT INTO frpm (CDSCode, "Academic Year", "District Code") VALUES ('S005', '2019-2020', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "Academic Year" FROM frpm WHERE "District Code" = 1234;

/*
Gold Result:
('2021-2022',)
*/

-- Prediction Query
SELECT "Academic Year" FROM frpm;

/*
Prediction Result:
('2020-2021',)
('2021-2022',)
('2022-2023',)
('2023-2024',)
('2019-2020',)
*/