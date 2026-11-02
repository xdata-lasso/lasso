-- Schema DDL
CREATE TABLE depts (name TEXT PRIMARY KEY, bldg TEXT);

CREATE TABLE profs (id INTEGER PRIMARY KEY, dept_name TEXT, FOREIGN KEY (dept_name) REFERENCES depts (name));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: depts --
INSERT INTO "depts" ("name", "bldg") VALUES ('pro_e4ef55', '5k5swwqcgs');

-- Inserting into table: profs --
INSERT INTO "profs" ("id", "dept_name") VALUES (1, 'pro_e4ef55');

INSERT INTO "profs" ("id", "dept_name") VALUES (2, 'pro_e4ef55');

INSERT INTO "profs" ("id", "dept_name") VALUES (3, 'pro_e4ef55');

INSERT INTO "profs" ("id", "dept_name") VALUES (4, 'pro_e4ef55');

INSERT INTO "profs" ("id", "dept_name") VALUES (5, 'pro_e4ef55');
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
(1, 'pro_e4ef55')
(2, 'pro_e4ef55')
(3, 'pro_e4ef55')
(4, 'pro_e4ef55')
(5, 'pro_e4ef55')
*/