-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Spring', 'Hall A', '2010', '2015', 3);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Teqnology', 'Hall B', '2008', '2020', 5);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (3, 'Technology', 'Hall C', '2009', '2019', 4);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (4, 'Winter', 'Hall D', '2012', '2018', 2);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (5, NULL, 'Hall E', '2011', '2016', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_year", "last_year" FROM "party" WHERE ("party_theme" = 'Spring' OR "party_theme" = 'Teqnology') ORDER BY first_year, party.party_id NULLS LAST;

/*
Gold Result:
('2008', '2020')
('2010', '2015')
*/

-- Prediction Query
SELECT First_year, Last_year FROM party WHERE Party_Theme = 'Spring' OR Party_Theme = 'Teqnology';

/*
Prediction Result:
('2010', '2015')
('2008', '2020')
*/