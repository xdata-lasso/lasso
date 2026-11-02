-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Spring', 'NY', '2020', '2021', 1);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Teqnology', 'LA', '2010', '2015', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_year", "last_year" FROM "party" WHERE ("party_theme" = 'Spring' OR "party_theme" = 'Teqnology') ORDER BY first_year, party.party_id NULLS LAST;

/*
Gold Result:
('2010', '2015')
('2020', '2021')
*/

-- Prediction Query
SELECT First_year, Last_year FROM party WHERE Party_Theme = 'Spring' OR Party_Theme = 'Teqnology';

/*
Prediction Result:
('2020', '2021')
('2010', '2015')
*/