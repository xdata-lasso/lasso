-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'Spring Gala', 'New York', '2015', '2020', 2);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'Winter Ball', 'London', '2018', '2022', 1);
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (1, 'Alice', NULL, '60');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (2, 'Alice', 'British', '60');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (3, 'Bob', 'American', '60');
INSERT INTO host (Host_ID, Name, Nationality, Age) VALUES (4, 'Charlie', 'Canadian', '45');
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 2, 1);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (2, 2, 0);
INSERT INTO party_host (Party_ID, Host_ID, Is_Main_in_Charge) VALUES (1, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, nationality FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.maxage AS maxage, RHS.host_id AS host_id_other, RHS.name AS name_other, RHS.nationality AS nationality_other, RHS.age AS age_other, RHS.maxage AS maxage_other FROM (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS LHS CROSS JOIN (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS RHS) WHERE (age = maxage AND age_other = maxage_other) ORDER BY name, nationality NULLS LAST;

/*
Gold Result:
('Alice', 'British')
('Alice', 'British')
('Alice', 'British')
('Alice', None)
('Alice', None)
('Alice', None)
('Bob', 'American')
('Bob', 'American')
('Bob', 'American')
*/

-- Prediction Query
SELECT Name, Nationality FROM HOST ORDER BY Age DESC, HOST.host_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', None)
*/