-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of order relative to Party_ID), duplicate themes (kills DISTINCT mutants), and unreferenced parties (kills INNER JOIN with party_host mutants).
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Zebra', 'New York', '2000', '2005', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Apple', 'London', '1999', '2010', 1);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (3, 'Banana', 'Paris', '2001', '2001', 3);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (4, 'Apple', 'Tokyo', '2005', '2015', 0);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (10, 'Alice', 'USA', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (20, 'Bob', 'UK', '45');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 10, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 20, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('Apple',)
('Apple',)
('Banana',)
('Zebra',)
*/

-- Prediction Query
SELECT Party_Theme FROM party ORDER BY Number_of_hosts ASC, party.party_id NULLS LAST;

/*
Prediction Result:
('Apple',)
('Apple',)
('Zebra',)
('Banana',)
*/