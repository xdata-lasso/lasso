-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (1, 'Alice', 'USA', '45');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (2, 'Bob', 'Canada', '44');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (3, 'Charlie', 'UK', '46');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (4, 'David', 'France', NULL);
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (5, 'Eve', 'Germany', '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM host WHERE (age = 45) ORDER BY nationality, host.host_id NULLS LAST;

/*
Gold Result:
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM HOST WHERE Age > 45 INTERSECT SELECT Nationality FROM HOST WHERE Age < 35;

/*
Prediction Result:
*/