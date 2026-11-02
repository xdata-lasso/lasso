-- Schema DDL
CREATE TABLE "Scientists" ("SSN" INTEGER PRIMARY KEY, "Name" TEXT(30));

CREATE TABLE "Projects" ("Code" TEXT(4) PRIMARY KEY, "Name" TEXT(50), "Hours" INTEGER);

CREATE TABLE "AssignedTo" ("Scientist" INTEGER, "Project" TEXT(4), PRIMARY KEY ("Scientist", "Project"), FOREIGN KEY ("Project") REFERENCES "Projects" ("Code"), FOREIGN KEY ("Scientist") REFERENCES "Scientists" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests GROUP BY (hours, name) vs GROUP BY (hours).
-- Two identically named projects ('Zeta') have the highest hours (1000).
-- Under GROUP BY (hours, name), they collapse into 1 row, so the 2nd output row is 'Eta' (500).
-- Without GROUP BY, 'Zeta' would appear twice.
-- Also tests lower hours having multiple distinct names to catch GROUP BY (hours) only if top row is skipped.
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P001', 'Zeta', 1000);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P002', 'Zeta', 1000);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P003', 'Eta', 500);
INSERT INTO "Projects" ("Code", "Name", "Hours") VALUES ('P004', 'Theta', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT hours, name, AVG(hours) AS meanhours FROM projects GROUP BY hours, name) ORDER BY hours DESC) LIMIT 2);

/*
Gold Result:
('Zeta',)
('Eta',)
*/

-- Prediction Query
SELECT name FROM projects WHERE hours > (SELECT AVG(hours) FROM projects);

/*
Prediction Result:
('Zeta',)
('Zeta',)
*/