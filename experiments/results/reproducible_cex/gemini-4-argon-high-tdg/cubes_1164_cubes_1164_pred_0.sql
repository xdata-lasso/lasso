-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring Gala', 'New York', '2010', '2020', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Summer Fest', 'Toronto', '2015', '2022', 3);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (45, 'Autumn Ball', 'Tokyo', '2000', '2018', 45);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Alice', 'USA', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Bob', 'Canada', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (3, 'Charlie', 'USA', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (4, 'David', 'France', '44');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (5, 'Eve', 'Germany', '46');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (45, 'Frank', 'Japan', '30');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 2, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 2, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 4, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (45, 45, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM host WHERE (age = 45) ORDER BY nationality, host.host_id NULLS LAST;

/*
Gold Result:
('Canada',)
('USA',)
('USA',)
*/

-- Prediction Query
SELECT Nationality FROM HOST WHERE Age > 45 INTERSECT SELECT Nationality FROM HOST WHERE Age < 35;

/*
Prediction Result:
*/