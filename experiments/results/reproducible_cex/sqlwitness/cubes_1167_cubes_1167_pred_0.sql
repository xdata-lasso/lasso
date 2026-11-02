-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, party_theme, location, first_year, last_year, number_of_hosts) VALUES (1, 'default1', 'Spring', 'default2', 'Teqnology', 1), (0, 'default1', 'default1', 'default2', NULL, NULL), (2, 'default2', NULL, 'Teqnology', 'Spring', NULL), (3, 'default1', 'Spring', 'default1', 'default1', 1), (4, 'Spring', 'Teqnology', 'default2', 'Teqnology', 1), (5, 'Teqnology', NULL, 'default1', 'Spring', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_year", "last_year" FROM "party" WHERE ("party_theme" = 'Spring' OR "party_theme" = 'Teqnology') ORDER BY first_year, party.party_id NULLS LAST;

/*
Gold Result:
('default1', 'Spring')
('default2', 'Teqnology')
*/

-- Prediction Query
SELECT First_year, Last_year FROM party WHERE Party_Theme = 'Spring' OR Party_Theme = 'Teqnology';

/*
Prediction Result:
('default2', 'Teqnology')
('default1', 'Spring')
*/