-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("code", "name", "hours") VALUES ('none', 'Patty Perez', 108);
INSERT INTO "projects" ("code", "name", "hours") VALUES ('wish', 'Carla Gray', 108);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM projects WHERE (hours >= 100 AND hours <= 300) ORDER BY name, projects.code NULLS LAST;

/*
Gold Result:
('Carla Gray',)
('Patty Perez',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours BETWEEN 100 AND 300;

/*
Prediction Result:
('Patty Perez',)
('Carla Gray',)
*/