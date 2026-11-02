-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (10, 'Rock', 'Zurich', '2015', '2018', 20);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (20, 'Jazz', 'Berlin', '2010', '2015', 99);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (30, 'Pop', 'Amsterdam', '2020', '2022', 40);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (40, 'Folk', 'Vienna', '2019', '2020', 88);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Alice', 'Swiss', '30');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Bob', 'German', '40');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (3, 'Clara', 'Dutch', '25');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (20, 1, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (20, 2, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (40, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.party_id AS party_id, LHS.is_main_in_charge AS is_main_in_charge, RHS.party_theme AS party_theme, RHS.location AS LOCATION, RHS.first_year AS first_year, RHS.last_year AS last_year, RHS.number_of_hosts AS number_of_hosts, RHS.party_theme_other AS party_theme_other, RHS.location_other AS location_other, RHS.first_year_other AS first_year_other, RHS.number_of_hosts_other AS number_of_hosts_other FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.party_id AS party_id, RHS.is_main_in_charge AS is_main_in_charge FROM host AS LHS INNER JOIN party_host AS RHS ON (LHS.host_id = RHS.host_id)) AS LHS INNER JOIN (SELECT party_id, party_theme, LOCATION, first_year, first_year AS last_year, number_of_hosts, party_theme_other, location_other, first_year_other, number_of_hosts_other FROM (SELECT number_of_hosts AS party_id, party_theme, LOCATION, first_year, last_year, number_of_hosts, party_theme_other, location_other, first_year_other, number_of_hosts_other FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.party_theme AS party_theme_other, RHS.location AS location_other, RHS.first_year AS first_year_other, RHS.number_of_hosts AS number_of_hosts_other FROM party AS LHS INNER JOIN party AS RHS ON (LHS.number_of_hosts = RHS.party_id AND LHS.first_year = RHS.last_year)))) AS RHS ON (LHS.party_id = RHS.party_id)) ORDER BY LOCATION;

/*
Gold Result:
('Amsterdam',)
('Zurich',)
('Zurich',)
*/

-- Prediction Query
SELECT T3.Location FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID WHERE T2.Age > 50;

/*
Prediction Result:
*/