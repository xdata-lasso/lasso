-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1005, 'Kimberly Garza', 'Antigua and Barbuda', 'all');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1006, 'Kimberly Garza', 'Antigua and Barbuda', 'better');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1007, 'Kimberly Garza', 'Antigua and Barbuda', 'discover');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1008, 'Kimberly Garza', 'Antigua and Barbuda', 'early');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1009, NULL, 'Pakistan', 'science');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1010, NULL, 'Pakistan', 'offer');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1011, NULL, 'Pakistan', 'kind');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1012, NULL, 'Pakistan', 'discussion');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1013, 'Donald Booth', 'Pakistan', 'song');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1014, 'Donald Booth', 'Pakistan', 'sure');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1015, 'Donald Booth', 'Pakistan', 'collection');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1016, 'Donald Booth', 'Pakistan', 'save');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT name, nationality, COUNT(*) AS n FROM host GROUP BY name, nationality) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('Antigua and Barbuda',)
*/

-- Prediction Query
SELECT Nationality FROM HOST GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('Pakistan',)
*/