-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic alphabetical ordering on Name, contrasting with ordering on Code or Hours, and includes unassigned projects to catch unnecessary INNER JOINs.
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Alice');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P001', 'Zeta', 10);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P002', 'Beta', 100);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P003', 'Alpha', 50);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P001');
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM projects ORDER BY name, projects.code NULLS LAST) LIMIT 1);

/*
Gold Result:
('Alpha',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/