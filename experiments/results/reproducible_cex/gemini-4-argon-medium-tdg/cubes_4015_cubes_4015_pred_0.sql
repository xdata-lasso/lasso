-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Zeta', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Alpha', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Alpha', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'Beta', 100);
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Dr. Smith');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Dr. Jones');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P002');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P004');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours FROM projects AS LHS INNER JOIN (SELECT MAX(hours) AS hours FROM projects) AS RHS ON (LHS.hours = RHS.hours)) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta',)
*/