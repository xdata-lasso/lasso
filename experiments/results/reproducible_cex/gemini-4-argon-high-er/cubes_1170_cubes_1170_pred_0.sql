-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring', 'Hall', '2020', '2021', 1);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'B', 'USA', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'A', 'USA', '25');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM host AS LHS WHERE NOT EXISTS(SELECT 1 FROM party_host AS RHS WHERE (LHS.host_id = RHS.host_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM HOST WHERE NOT Host_ID IN (SELECT Host_ID FROM party_host);

/*
Prediction Result:
*/