-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Scientists (SSN, Name) VALUES (101, 'Dr. Smith');
INSERT INTO Scientists (SSN, Name) VALUES (102, 'Dr. Jones');
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Zeta', 9);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P2', 'Alpha', 85);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P3', 'Omega', 20);
INSERT INTO Projects (Code, Name, Hours) VALUES ('P4', 'Beta', 100);
INSERT INTO AssignedTo (Scientist, Project) VALUES (101, 'P1');
INSERT INTO AssignedTo (Scientist, Project) VALUES (102, 'P3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT hours, name, AVG(hours) AS meanhours FROM projects GROUP BY hours, name) ORDER BY hours DESC) LIMIT 2);

/*
Gold Result:
('Beta',)
('Alpha',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours > (SELECT AVG(hours) FROM projects);

/*
Prediction Result:
('Alpha',)
('Beta',)
*/