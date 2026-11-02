-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Scientists (SSN, Name) VALUES (201, 'David Green');
INSERT INTO Scientists (SSN, Name) VALUES (202, 'Eva Black');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Zeta Project', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Gamma Project', 150);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Beta Project', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'Alpha Project', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P005', 'Epsilon Project', 300);
INSERT INTO AssignedTo (Scientist, Project) VALUES (201, 'P003');
INSERT INTO AssignedTo (Scientist, Project) VALUES (202, 'P003');
INSERT INTO AssignedTo (Scientist, Project) VALUES (201, 'P002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours FROM projects AS LHS INNER JOIN (SELECT MAX(hours) AS hours FROM projects) AS RHS ON (LHS.hours = RHS.hours)) ORDER BY name;

/*
Gold Result:
('Alpha Project',)
('Beta Project',)
('Zeta Project',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Project',)
*/