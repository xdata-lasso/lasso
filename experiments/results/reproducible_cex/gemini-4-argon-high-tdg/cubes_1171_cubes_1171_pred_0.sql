-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring', 'Hall B', '2010', '2015', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Autumn', 'Hall Z', '2012', '2016', 1);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (3, 'Autumn', 'Hall A', '2014', '2018', 0);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (4, 'Autumn', 'Hall A', '2019', '2020', 3);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Alice', 'USA', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Bob', 'UK', '45');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 1, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 2, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, LOCATION FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('Autumn', 'Hall Z')
('Autumn', 'Hall A')
('Autumn', 'Hall A')
('Spring', 'Hall B')
*/

-- Prediction Query
SELECT Party_Theme, LOCATION FROM party;

/*
Prediction Result:
('Spring', 'Hall B')
('Autumn', 'Hall Z')
('Autumn', 'Hall A')
('Autumn', 'Hall A')
*/