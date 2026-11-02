-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P001', 'Alpha', 99);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P002', 'Beta', 100);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P003', 'Gamma', 101);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P004', 'Delta', 200);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P005', 'Epsilon', 299);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P006', 'Zeta', 300);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P007', 'Eta', 301);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P008', 'Theta', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM projects WHERE (hours >= 100 AND hours <= 300) ORDER BY name, projects.code NULLS LAST;

/*
Gold Result:
('Beta',)
('Delta',)
('Epsilon',)
('Gamma',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300;

/*
Prediction Result:
('Beta',)
('Gamma',)
('Delta',)
('Epsilon',)
('Zeta',)
*/