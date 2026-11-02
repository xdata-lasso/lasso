-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (Age = '45' vs boundary values '44', '46', NULL), duplicates in Nationality (catches DISTINCT mutants), and ORDER BY nationality ASC vs DESC.
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (10, 'Alice', 'USA', '45');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (20, 'Bob', 'Canada', '45');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (5, 'Charlie', 'Canada', '45');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (30, 'David', 'UK', '44');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (40, 'Eve', 'Germany', '46');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (50, 'Frank', 'France', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM host WHERE (age = 45) ORDER BY nationality, host.host_id NULLS LAST;

/*
Gold Result:
('Canada',)
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM HOST WHERE Age > 45 INTERSECT SELECT Nationality FROM HOST WHERE Age < 35;

/*
Prediction Result:
*/