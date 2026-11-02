-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Scientists" ("ssn", "name") VALUES (8, '11');
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('10', '8', 8);
INSERT INTO "Projects" ("code", "name", "hours") VALUES ('9', '8', 8);
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (8, '10');
INSERT INTO "AssignedTo" ("scientist", "project") VALUES (8, '9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM scientists ORDER BY name, scientists.ssn NULLS LAST;

/*
Gold Result:
('11',)
*/

-- Prediction Query
SELECT T2.name FROM assignedto AS T1 JOIN scientists AS T2 ON T1.scientist = T2.ssn;

/*
Prediction Result:
('11',)
('11',)
*/