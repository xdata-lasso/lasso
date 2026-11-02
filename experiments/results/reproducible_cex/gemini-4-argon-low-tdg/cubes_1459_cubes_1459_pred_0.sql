-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Scientists (SSN, Name) VALUES (10, 'Charlie');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'ProjectX', 50);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'ProjectX', 50);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'ProjectX', 60);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'ProjectY', 50);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P005', 'ProjectZ', 70);
INSERT INTO AssignedTo (Scientist, Project) VALUES (10, 'P001');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM projects AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT code, name, hours, scientist, code AS project FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.hours AS hours, RHS.scientist AS scientist FROM projects AS LHS INNER JOIN assignedto AS RHS ON (LHS.code = RHS.project))) AS RHS WHERE (LHS.hours = RHS.hours AND LHS.name = RHS.name))) ORDER BY name;

/*
Gold Result:
('ProjectX',)
('ProjectY',)
('ProjectZ',)
*/

-- Prediction Query
SELECT Name FROM Projects WHERE NOT Code IN (SELECT Project FROM AssignedTo);

/*
Prediction Result:
('ProjectX',)
('ProjectX',)
('ProjectY',)
('ProjectZ',)
*/