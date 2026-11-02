-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P001', 'A', 10);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P002', 'B', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM projects ORDER BY name, projects.code NULLS LAST) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT name FROM projects ORDER BY hours DESC, projects.code NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/