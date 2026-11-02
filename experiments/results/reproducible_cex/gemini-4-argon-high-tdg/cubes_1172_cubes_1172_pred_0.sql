-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Winter Gala', 'New York', '2010', '2020', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Autumn Harvest', 'Boston', '2015', '2019', 1);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (3, 'Spring Blossom', 'Chicago', '2012', '2022', 0);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (4, 'Autumn Harvest', 'Seattle', '2018', '2021', 3);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (10, 'Alice Smith', 'USA', '34');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (20, 'Bob Jones', 'Canada', '41');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 10, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 20, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('Autumn Harvest',)
('Autumn Harvest',)
('Spring Blossom',)
('Winter Gala',)
*/

-- Prediction Query
SELECT Party_Theme FROM party ORDER BY Number_of_hosts ASC, party.party_id NULLS LAST;

/*
Prediction Result:
('Spring Blossom',)
('Autumn Harvest',)
('Winter Gala',)
('Autumn Harvest',)
*/