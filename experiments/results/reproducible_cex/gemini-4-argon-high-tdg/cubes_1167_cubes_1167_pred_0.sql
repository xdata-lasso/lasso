-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (3, 'Spring', 'New York', '2000', '2005', 2);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Teqnology', 'London', '2000', '2010', 0);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Spring', 'Paris', '1998', '2002', 1);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (4, 'Teqnology', 'Berlin', '1998', '2002', 1);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (5, 'Summer', 'Tokyo', '1995', '1999', 3);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (6, 'Technology', 'Rome', '2001', '2004', 2);
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (10, 'Alice', 'USA', '30');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (20, 'Bob', 'UK', '40');
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (3, 10, 1);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (3, 20, 0);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (2, 10, 0);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (5, 20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_year", "last_year" FROM "party" WHERE ("party_theme" = 'Spring' OR "party_theme" = 'Teqnology') ORDER BY first_year, party.party_id NULLS LAST;

/*
Gold Result:
('1998', '2002')
('1998', '2002')
('2000', '2010')
('2000', '2005')
*/

-- Prediction Query
SELECT First_year, Last_year FROM party WHERE Party_Theme = 'Spring' OR Party_Theme = 'Teqnology';

/*
Prediction Result:
('2000', '2010')
('1998', '2002')
('2000', '2005')
('1998', '2002')
*/