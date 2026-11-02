-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'B', 'Location 1', '2020', '2021', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'A', 'Location 2', '2020', '2021', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, LOCATION FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('A', 'Location 2')
('B', 'Location 1')
*/

-- Prediction Query
SELECT Party_Theme, LOCATION FROM party;

/*
Prediction Result:
('B', 'Location 1')
('A', 'Location 2')
*/