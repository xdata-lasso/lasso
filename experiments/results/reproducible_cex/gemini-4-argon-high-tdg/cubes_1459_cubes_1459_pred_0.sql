-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Marie Curie');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Albert Einstein');
INSERT INTO Scientists (SSN, Name) VALUES (103, 'Isaac Newton');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Zeta', 10);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Alpha', 30);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Beta', 20);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Gamma', 40);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P5', 'Delta', 50);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P4');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P5');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM projects AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT code, name, hours, scientist, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.scientist AS scientist FROM projects AS LHS INNER JOIN assignedto AS RHS ON (LHS.code = RHS.project))) AS RHS WHERE (LHS.hours = RHS.hours AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT Name FROM Projects WHERE NOT Code IN (SELECT Project FROM AssignedTo);

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Beta',)
*/