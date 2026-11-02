-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Party_Theme, secondary tie-breaking by Party_ID, and unreferenced parties (catches INNER JOIN mutants).
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (3, 'Masquerade', 'Venice', '1990', '2020', 2);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Masquerade', 'Paris', '2000', '2022', 1);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Carnival', 'Rio', '1980', '2023', 5);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (4, 'Gala', 'New York', '2010', '2021', 3);
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (10, 'Alice', 'USA', '30');
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (1, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, LOCATION FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('Carnival', 'Rio')
('Gala', 'New York')
('Masquerade', 'Paris')
('Masquerade', 'Venice')
*/

-- Prediction Query
SELECT Party_Theme, LOCATION FROM party;

/*
Prediction Result:
('Masquerade', 'Paris')
('Carnival', 'Rio')
('Masquerade', 'Venice')
('Gala', 'New York')
*/