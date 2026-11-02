-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring Gala', 'New York', '2015', '2020', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Summer Fest', 'Miami', '2018', '2022', 1);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Zack', 'USA', '29');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Charlie', 'UK', '41');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (3, 'Alice', 'Canada', '34');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (4, 'Bob', 'Australia', '50');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 2, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 4, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM host AS LHS WHERE NOT EXISTS(SELECT 1 FROM party_host AS RHS WHERE (LHS.host_id = RHS.host_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM HOST WHERE NOT Host_ID IN (SELECT Host_ID FROM party_host);

/*
Prediction Result:
('Zack',)
('Alice',)
*/