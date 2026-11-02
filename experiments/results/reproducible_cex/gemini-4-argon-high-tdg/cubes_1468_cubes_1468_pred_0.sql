-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Alice Smith');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Bob Jones');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Zeta Research', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Alpha Initiative', 300);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Gamma Study', 200);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P004', 'Beta Analysis', 99);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P005', 'Delta Project', 301);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P006', 'Epsilon Task', NULL);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P004');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P005');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM projects WHERE (hours >= 100 AND hours <= 300) ORDER BY name, projects.code NULLS LAST;

/*
Gold Result:
('Alpha Initiative',)
('Gamma Study',)
('Zeta Research',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300;

/*
Prediction Result:
('Zeta Research',)
('Alpha Initiative',)
('Gamma Study',)
*/