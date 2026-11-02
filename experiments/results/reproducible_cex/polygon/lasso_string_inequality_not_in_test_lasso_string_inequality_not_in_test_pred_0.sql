-- Schema DDL
CREATE TABLE depts (name TEXT PRIMARY KEY, bldg TEXT);

CREATE TABLE profs (id INTEGER PRIMARY KEY, dept_name TEXT, FOREIGN KEY (dept_name) REFERENCES depts (name));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "depts" ("name", "bldg") VALUES ('West14', 'West2413595805746393125');
INSERT INTO "depts" ("name", "bldg") VALUES ('West13', 'West-388');
INSERT INTO "profs" ("id", "dept_name") VALUES (11, NULL);
INSERT INTO "profs" ("id", "dept_name") VALUES (10, 'West13');
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
*/