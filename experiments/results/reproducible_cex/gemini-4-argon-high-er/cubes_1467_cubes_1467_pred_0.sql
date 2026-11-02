-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Projects (Code, Name, Hours) VALUES ('P1', 'Project A', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT hours, name, AVG(hours) AS meanhours FROM projects GROUP BY hours, name) ORDER BY hours DESC) LIMIT 2);

/*
Gold Result:
('Project A',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours > (SELECT AVG(hours) FROM projects);

/*
Prediction Result:
*/