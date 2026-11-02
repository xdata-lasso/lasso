-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('A', 'Zeta', 150);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('B', 'Alpha', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM projects WHERE (hours >= 100 AND hours <= 300) ORDER BY name, projects.code NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300;

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/