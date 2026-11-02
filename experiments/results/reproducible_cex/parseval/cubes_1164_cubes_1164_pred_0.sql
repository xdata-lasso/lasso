-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: host --
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1, '5k5swwqcgs', 'hos_b33def', '45');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (3, '9n8', 'hos_b33def', '45');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (2, '4', 'gu7v', 'hos_852f7e');

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (4, 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (5, 'rwbbp6luhvd', NULL, '45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM host WHERE (age = 45) ORDER BY nationality, host.host_id NULLS LAST;

/*
Gold Result:
(None,)
('hos_b33def',)
('hos_b33def',)
*/

-- Prediction Query
SELECT Nationality FROM HOST WHERE Age > 45 INTERSECT SELECT Nationality FROM HOST WHERE Age < 35;

/*
Prediction Result:
*/