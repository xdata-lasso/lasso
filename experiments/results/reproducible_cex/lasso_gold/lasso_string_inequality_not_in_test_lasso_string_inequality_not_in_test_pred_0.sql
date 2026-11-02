-- Schema DDL
CREATE TABLE depts (name TEXT PRIMARY KEY, bldg TEXT);

CREATE TABLE profs (id INTEGER PRIMARY KEY, dept_name TEXT, FOREIGN KEY (dept_name) REFERENCES depts (name));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "depts" ("name", "bldg") VALUES ('Heidi Lee', 'Wes');
INSERT INTO "depts" ("name", "bldg") VALUES ('Dr. Sharon James', 'Wes');
INSERT INTO "profs" ("id", "dept_name") VALUES (1009, 'Heidi Lee');
INSERT INTO "profs" ("id", "dept_name") VALUES (1010, 'Heidi Lee');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg <> 'West');

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM profs WHERE NOT dept_name IN (SELECT name FROM depts WHERE bldg > 'West');

/*
Prediction Result:
(1009, 'Heidi Lee')
(1010, 'Heidi Lee')
*/