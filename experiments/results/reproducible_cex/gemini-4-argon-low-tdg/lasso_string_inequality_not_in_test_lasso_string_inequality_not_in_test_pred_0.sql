-- Schema DDL
CREATE TABLE depts (name TEXT PRIMARY KEY, bldg TEXT);

CREATE TABLE profs (id INTEGER PRIMARY KEY, dept_name TEXT, FOREIGN KEY (dept_name) REFERENCES depts (name));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO depts (name, bldg) VALUES ('CS', 'West');
INSERT INTO depts (name, bldg) VALUES ('Math', 'East');
INSERT INTO depts (name, bldg) VALUES ('History', NULL);
INSERT INTO depts (name, bldg) VALUES ('Bio', 'west');
INSERT INTO profs (id, dept_name) VALUES (1, 'CS');
INSERT INTO profs (id, dept_name) VALUES (2, 'CS');
INSERT INTO profs (id, dept_name) VALUES (3, 'Math');
INSERT INTO profs (id, dept_name) VALUES (4, 'History');
INSERT INTO profs (id, dept_name) VALUES (5, 'Bio');
INSERT INTO profs (id, dept_name) VALUES (6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg <> 'West');

/*
Gold Result:
(1, 'CS')
(2, 'CS')
(4, 'History')
*/

-- Prediction Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg > 'West');

/*
Prediction Result:
(1, 'CS')
(2, 'CS')
(3, 'Math')
(4, 'History')
*/