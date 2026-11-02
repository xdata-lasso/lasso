-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Retro', 'Hall B', '2000', '2005', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Retro', 'Hall A', '1999', '2004', 1);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (3, 'Gala', 'Hall C', '2001', '2006', 3);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (4, 'Gala', 'Hall C', '2002', '2007', 4);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (10, 'Alice', 'USA', '30');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, LOCATION FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('Gala', 'Hall C')
('Gala', 'Hall C')
('Retro', 'Hall A')
('Retro', 'Hall B')
*/

-- Prediction Query
SELECT Party_Theme, LOCATION FROM party;

/*
Prediction Result:
('Retro', 'Hall A')
('Retro', 'Hall B')
('Gala', 'Hall C')
('Gala', 'Hall C')
*/