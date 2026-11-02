-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring Gala', 'New York', '2010', '2020', 5);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Winter Ball', 'London', '2015', '2022', 2);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Alexander', 'Argentina', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Alexander', 'Argentina', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (3, 'Alexander', 'Argentina', '45');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (4, 'Zoe', 'France', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (5, 'Zoe', 'France', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (6, 'Al', 'Zimbabwe', '20');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 1, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT name, nationality, COUNT(*) AS n FROM host GROUP BY name, nationality) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
('France',)
*/

-- Prediction Query
SELECT Nationality FROM HOST GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('Argentina',)
*/