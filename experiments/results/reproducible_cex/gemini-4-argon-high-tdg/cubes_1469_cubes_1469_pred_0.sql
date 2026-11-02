-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Ada Lovelace');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Alan Turing');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Gamma', 10);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Beta', 500);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Alpha', 50);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Omega', 100);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P4');
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